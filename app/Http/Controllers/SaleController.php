<?php

namespace App\Http\Controllers;

use App\Models\Sale;
use App\Models\SaleItem;
use App\Models\Seller;
use App\Models\Product;
use App\Models\Currency;
use App\Models\Person;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;
use Hekmatinasser\Verta\Verta;
use PDF;

class SaleController extends Controller
{

    public function nextInvoiceNumber()
    {
        $last = Sale::orderByDesc('invoice_number')->first();
        $next = $last && $last->invoice_number ? $last->invoice_number + 1 : 1001;
        return response()->json(['invoice_number' => $next]);
    }

    public function print(Sale $sale)
    {
        $sale->load(['customer', 'seller', 'items.product']);
        return view('sales.print', compact('sale'));
    }

    public function index(Request $request)
    {
        $baseQuery = Sale::with(['seller', 'customer', 'items.product', 'currency']);

        if ($request->filled('search')) {
            $search = $request->search;
            $baseQuery->where(function($q) use ($search) {
                $q->where('invoice_number', 'like', "%{$search}%")
                  ->orWhere('reference', 'like', "%{$search}%")
                  ->orWhere('title', 'like', "%{$search}%")
                  ->orWhereHas('customer', function($q) use ($search) {
                      $q->where('first_name', 'like', "%{$search}%")
                        ->orWhere('last_name', 'like', "%{$search}%");
                  });
            });
        }

        if ($request->filled('customer')) {
            $baseQuery->where('customer_id', $request->customer);
        }

        if ($request->filled('seller')) {
            $baseQuery->where('seller_id', $request->seller);
        }

        if ($request->filled('status')) {
            $baseQuery->where('status', $request->status);
        }

        if ($request->filled('date_range')) {
            $dates = explode(' - ', $request->date_range);
            if (count($dates) == 2) {
                $start = Carbon::createFromFormat('Y/m/d', trim($dates[0]))->startOfDay();
                $end = Carbon::createFromFormat('Y/m/d', trim($dates[1]))->endOfDay();
                $baseQuery->whereBetween('created_at', [$start, $end]);
            }
        }

        if ($request->filled('price_min')) {
            $baseQuery->where('total_price', '>=', $request->price_min);
        }

        if ($request->filled('price_max')) {
            $baseQuery->where('total_price', '<=', $request->price_max);
        }

        $sortField = $request->sort_by ?? 'created_at';
        $sortOrder = $request->sort_order ?? 'desc';
        $perPage = $request->per_page ?? 10;

        $sales = (clone $baseQuery)->orderBy($sortField, $sortOrder)->paginate($perPage)->withQueryString();

        $totalSales = (clone $baseQuery)->sum('total_price');
        $salesCount = (clone $baseQuery)->count();
        $averageSale = $salesCount > 0 ? $totalSales / $salesCount : 0;
        $todaySales = (clone $baseQuery)->whereDate('created_at', Carbon::today())->sum('total_price');

        $customers = Person::whereHas('sales')->get();
        $sellers = Seller::whereHas('sales')->get();

        return view('sales.index', compact(
            'sales',
            'customers',
            'sellers',
            'totalSales',
            'salesCount',
            'averageSale',
            'todaySales'
        ));
    }

    public function create()
    {
        $sellers = Seller::all();
        $products = Product::with('category')->where('type', 'product')->get();
        $services = Product::with('category')->where('type', 'service')->get();
        $currencies = Currency::all();
        $customers = Person::all();

        $nextNumber = $this->generateNextInvoiceNumber();

        return view('sales.create', compact(
            'sellers',
            'products',
            'services',
            'currencies',
            'customers',
            'nextNumber'
        ));
    }

    public function store(Request $request)
    {
        $request->validate([
            'customer_id'    => 'required|exists:persons,id',
            'seller_id'      => 'required|exists:sellers,id',
            'currency_id'    => 'required|exists:currencies,id',
            'products_input' => 'required',
        ]);

        DB::beginTransaction();
        try {
            $items = json_decode($request->products_input, true);
            if (empty($items)) {
                throw new \Exception('هیچ محصولی انتخاب نشده است.');
            }

            // ایجاد فاکتور
            $sale = Sale::create([
                'invoice_number' => $this->generateNextInvoiceNumber(),
                'reference'      => $request->reference,
                'customer_id'    => $request->customer_id,
                'seller_id'      => $request->seller_id,
                'currency_id'    => $request->currency_id,
                'title'          => $request->title ?? 'فروش',
                'issued_at'      => now(),
                'status'         => 'pending'
            ]);

            // ثبت اقلام فاکتور
            foreach ($items as $item) {
                $product = Product::findOrFail($item['id']);

                // بررسی موجودی
                if ($product->type === 'product' && $product->stock < $item['count']) {
                    throw new \Exception("موجودی محصول '{$product->name}' کافی نیست.");
                }

                // ایجاد قلم فاکتور
                SaleItem::create([
                    'sale_id'     => $sale->id,
                    'product_id'  => $product->id,
                    'quantity'    => $item['count'],
                    'unit_price'  => $item['sell_price'],
                    'discount'    => $item['discount'] ?? 0,
                    'tax'         => ($item['tax'] ?? 0),
                    'description' => $item['desc'] ?? '',
                    'unit'        => $item['unit'] ?? '',
                    'total'       => ($item['count'] * $item['sell_price']) - ($item['discount'] ?? 0)
                ]);

                // کم کردن موجودی
                if ($product->type === 'product') {
                    $product->stock -= $item['count'];
                    $product->save();
                }
            }

            // محاسبه مجدد مبالغ فاکتور
            $sale->calculateTotals();

            DB::commit();
            return redirect()->route('sales.show', $sale)->with('success', 'فاکتور با موفقیت ثبت شد.');
        } catch (\Exception $e) {
            DB::rollBack();
            return back()->withInput()->withErrors(['error' => $e->getMessage()]);
        }
    }

    public function show(Sale $sale)
    {
        $sale->load(['customer', 'seller', 'items.product', 'currency']);
        return view('sales.show', compact('sale'));
    }

    public function edit(Sale $sale)
    {
        if ($sale->status !== 'pending') {
            return redirect()->route('sales.show', $sale)
                           ->with('error', 'فقط فاکتورهای در انتظار پرداخت قابل ویرایش هستند.');
        }

        $sale->load(['customer', 'seller', 'items.product', 'currency']);
        $sellers = Seller::all();
        $products = Product::with('category')->get();
        $currencies = Currency::all();
        $customers = Person::all();

        return view('sales.edit', compact('sale', 'sellers', 'products', 'currencies', 'customers'));
    }

    public function update(Request $request, Sale $sale)
    {
        if ($sale->status !== 'pending') {
            return redirect()->route('sales.show', $sale)
                           ->with('error', 'فقط فاکتورهای در انتظار پرداخت قابل ویرایش هستند.');
        }

        $request->validate([
            'invoice_number' => 'required|unique:sales,invoice_number,' . $sale->id,
            'customer_id' => 'required|exists:persons,id',
            'seller_id' => 'required|exists:sellers,id',
            'currency_id' => 'required|exists:currencies,id',
            'products_input' => 'required',
        ]);

        $items = json_decode($request->products_input, true);
        if (empty($items)) {
            return back()->withInput()->withErrors(['products' => 'حداقل یک محصول یا خدمت به فاکتور اضافه کنید.']);
        }

        DB::beginTransaction();
        try {
            // برگرداندن موجودی محصولات قبلی
            foreach ($sale->items as $item) {
                if ($item->product && $item->product->type === 'product') {
                    $item->product->increment('stock', $item->quantity);
                }
            }

            // محاسبه مجدد مبلغ کل
            $totalPrice = 0;
            $totalDiscount = 0;
            $totalTax = 0;

            foreach ($items as $item) {
                $count = intval($item['count']);
                $unitPrice = intval($item['sell_price']);
                $discount = floatval($item['discount'] ?? 0);
                $tax = floatval($item['tax'] ?? 0);

                $subtotal = $count * $unitPrice;
                $itemDiscount = $discount;
                $itemTax = ($subtotal - $itemDiscount) * ($tax / 100);

                $totalPrice += $subtotal;
                $totalDiscount += $itemDiscount;
                $totalTax += $itemTax;

                // بررسی و کم کردن موجودی جدید
                $product = Product::find($item['id']);
                if ($product && $product->type === 'product') {
                    if($product->stock < $count) {
                        throw new \Exception("موجودی محصول '{$product->name}' کافی نیست.");
                    }
                    $product->stock -= $count;
                    $product->save();
                }
            }

            // به‌روزرسانی فاکتور
            $sale->update([
                'invoice_number' => $request->invoice_number,
                'reference' => $request->reference,
                'customer_id' => $request->customer_id,
                'seller_id' => $request->seller_id,
                'currency_id' => $request->currency_id,
                'title' => $request->title,
                'total_price' => $totalPrice,
                'discount' => $totalDiscount,
                'tax' => $totalTax
            ]);

            // حذف اقلام قبلی
            $sale->items()->delete();

            // ذخیره اقلام جدید
            foreach ($items as $item) {
                $count = intval($item['count']);
                $unitPrice = intval($item['sell_price']);
                $discount = floatval($item['discount'] ?? 0);
                $tax = floatval($item['tax'] ?? 0);

                $subtotal = $count * $unitPrice;
                $itemDiscount = $discount;
                $itemTax = ($subtotal - $itemDiscount) * ($tax / 100);
                $total = $subtotal - $itemDiscount + $itemTax;

                SaleItem::create([
                    'sale_id' => $sale->id,
                    'product_id' => $item['id'],
                    'description' => $item['desc'] ?? '',
                    'unit' => $item['unit'] ?? '',
                    'quantity' => $count,
                    'unit_price' => $unitPrice,
                    'discount' => $itemDiscount,
                    'tax' => $itemTax,
                    'total' => $total
                ]);
            }

            DB::commit();
            return redirect()->route('sales.show', $sale)->with('success', 'فاکتور با موفقیت به‌روزرسانی شد.');
        } catch (\Exception $ex) {
            DB::rollBack();
            return back()->withInput()->withErrors(['error' => $ex->getMessage()]);
        }
    }

    public function destroy(Sale $sale)
    {
        if ($sale->status !== 'pending') {
            return response()->json([
                'success' => false,
                'message' => 'فقط فاکتورهای در انتظار پرداخت قابل حذف هستند.'
            ]);
        }

        DB::beginTransaction();
        try {
            // برگرداندن موجودی محصولات
            foreach ($sale->items as $item) {
                if ($item->product && $item->product->type === 'product') {
                    $item->product->increment('stock', $item->quantity);
                }
            }

            // حذف فاکتور و اقلام آن
            $sale->items()->delete();
            $sale->delete();

            DB::commit();
            return response()->json([
                'success' => true,
                'message' => 'فاکتور با موفقیت حذف شد.'
            ]);
        } catch (\Exception $ex) {
            DB::rollBack();
            return response()->json([
                'success' => false,
                'message' => 'خطا در حذف فاکتور: ' . $ex->getMessage()
            ]);
        }
    }

    public function updateStatus(Request $request, Sale $sale)
    {
        $request->validate([
            'payment_method' => 'required',
        ]);

        DB::beginTransaction();
        try {
            // مبلغ نهایی (final_amount) با دقت اعشاری
            $finalAmount = floatval($sale->total_price) - floatval($sale->discount) + floatval($sale->tax);

            // جمع کل پرداخت قبلی (با دقت اعشاری)
            $previousPaid = floatval($sale->paid_amount) ?: 0.0;
            $paidThisTime = 0.0;

            switch($request->payment_method) {
                case 'cash':
                    $paidThisTime = floatval($request->cash_amount);
                    $sale->cash_amount = $paidThisTime;
                    $sale->cash_reference = $request->cash_reference;
                    $sale->cash_paid_at = now();
                    break;

                case 'card':
                    $paidThisTime = floatval($request->card_amount);
                    $sale->card_amount = $paidThisTime;
                    $sale->card_number = $request->card_number;
                    $sale->card_bank = $request->card_bank;
                    $sale->card_reference = $request->card_reference;
                    $sale->card_paid_at = now();
                    break;

                case 'pos':
                    $paidThisTime = floatval($request->pos_amount);
                    $sale->pos_amount = $paidThisTime;
                    $sale->pos_terminal = $request->pos_terminal;
                    $sale->pos_reference = $request->pos_reference;
                    $sale->pos_paid_at = now();
                    break;

                case 'online':
                    $paidThisTime = floatval($request->online_amount);
                    $sale->online_amount = $paidThisTime;
                    $sale->online_transaction_id = $request->online_transaction_id;
                    $sale->online_reference = $request->online_reference;
                    $sale->online_paid_at = now();
                    break;

                case 'cheque':
                    $paidThisTime = floatval($request->cheque_amount);
                    $sale->cheque_amount = $paidThisTime;
                    $sale->cheque_number = $request->cheque_number;
                    $sale->cheque_bank = $request->cheque_bank;
                    $sale->cheque_due_date = $request->cheque_due_date;
                    $sale->cheque_status = 'pending';
                    $sale->cheque_received_at = now();
                    break;

                case 'multi':
                    // جمع همه مقادیر چندگانه
                    if($request->has('multi_cash_amount')) {
                        $paidThisTime += floatval($request->multi_cash_amount);
                        $sale->cash_amount = floatval($request->multi_cash_amount);
                        $sale->cash_reference = $request->multi_cash_reference;
                        $sale->cash_paid_at = now();
                    }
                    if($request->has('multi_card_amount')) {
                        $paidThisTime += floatval($request->multi_card_amount);
                        $sale->card_amount = floatval($request->multi_card_amount);
                        $sale->card_number = $request->multi_card_number;
                        $sale->card_bank = $request->multi_card_bank;
                        $sale->card_reference = $request->multi_card_reference;
                        $sale->card_paid_at = now();
                    }
                    if($request->has('multi_cheque_amount')) {
                        $paidThisTime += floatval($request->multi_cheque_amount);
                        $sale->cheque_amount = floatval($request->multi_cheque_amount);
                        $sale->cheque_number = $request->multi_cheque_number;
                        $sale->cheque_bank = $request->multi_cheque_bank;
                        $sale->cheque_due_date = $request->multi_cheque_due_date;
                        $sale->cheque_status = 'pending';
                        $sale->cheque_received_at = now();
                    }
                    break;
            }

            // جمع پرداخت نهایی
            $totalPaidAmount = $previousPaid + $paidThisTime;

            // محاسبه مانده با دقت اعشاری
            $remaining = $finalAmount - $totalPaidAmount;

            // اگر باقی‌مانده ناچیز بود (مثلاً کمتر از 5 تومان)، صفر فرض کن
            if (abs($remaining) < 5) {
                $remaining = 0;
            }
            if ($remaining < 0) {
                $remaining = 0;
            }

            $sale->final_amount = $finalAmount;
            $sale->paid_amount = $totalPaidAmount;
            $sale->remaining_amount = $remaining;

            // تعیین وضعیت پرداخت
            if ($remaining == 0) {
                $sale->status = 'paid';
                $sale->paid_at = now();
            } else {
                $sale->status = 'pending';
            }

            $sale->payment_method = $request->payment_method;
            $sale->payment_notes = $request->payment_notes;

            $sale->save();

            DB::commit();
            return redirect()->route('sales.show', $sale)->with('success', 'پرداخت با موفقیت ثبت شد.');
        } catch (\Exception $ex) {
            DB::rollBack();
            return back()->withInput()->withErrors(['error' => 'خطا در ثبت پرداخت: ' . $ex->getMessage()]);
        }
    }

    public function bulkDelete(Request $request)
    {
        $request->validate([
            'ids' => 'required|array',
            'ids.*' => 'exists:sales,id'
        ]);

        DB::beginTransaction();
        try {
            $sales = Sale::whereIn('id', $request->ids)
                        ->where('status', 'pending')
                        ->with('items.product')
                        ->get();

            foreach ($sales as $sale) {
                // برگرداندن موجودی محصولات
                foreach ($sale->items as $item) {
                    if ($item->product && $item->product->type === 'product') {
                        $item->product->increment('stock', $item->quantity);
                    }
                }

                // حذف فاکتور و اقلام آن
                $sale->items()->delete();
                $sale->delete();
            }

            DB::commit();
            return response()->json([
                'success' => true,
                'message' => count($sales) . ' فاکتور با موفقیت حذف شد.'
            ]);
        } catch (\Exception $ex) {
            DB::rollBack();
            return response()->json([
                'success' => false,
                'message' => 'خطا در حذف فاکتورها: ' . $ex->getMessage()
            ]);
        }
    }

    public function export(Request $request)
    {
        $request->validate([
            'format' => 'required|in:excel,pdf,csv',
            'date_range' => 'nullable|string',
            'selected_ids' => 'nullable|string'
        ]);

        $baseQuery = Sale::with(['customer', 'seller', 'items.product', 'currency']);

        // فیلتر بر اساس آیدی‌های انتخاب شده
        if ($request->filled('selected_ids')) {
            $ids = explode(',', $request->selected_ids);
            $baseQuery->whereIn('id', $ids);
        }

        // فیلتر تاریخ
        if ($request->filled('date_range')) {
            $dates = explode(' - ', $request->date_range);
            if (count($dates) == 2) {
                $start = Carbon::createFromFormat('Y/m/d', trim($dates[0]))->startOfDay();
                $end = Carbon::createFromFormat('Y/m/d', trim($dates[1]))->endOfDay();
                $baseQuery->whereBetween('created_at', [$start, $end]);
            }
        }

        $sales = $baseQuery->get();

        // ایجاد خروجی بر اساس فرمت درخواستی
        switch ($request->format) {
            case 'excel':
                return Excel::download(new SalesExport($sales), 'sales.xlsx');
            case 'pdf':
                $pdf = PDF::loadView('exports.sales-pdf', compact('sales'));
                return $pdf->download('sales.pdf');
            case 'csv':
                return Excel::download(new SalesExport($sales), 'sales.csv');
        }
    }

    protected function generateNextInvoiceNumber()
    {
        $lastSale = Sale::where('invoice_number', 'like', 'invoices-%')
            ->orderByRaw('CAST(SUBSTRING(invoice_number, 10) AS UNSIGNED) DESC')
            ->first();

        if ($lastSale && preg_match('/invoices-(\d+)/', $lastSale->invoice_number, $matches)) {
            $number = intval($matches[1]) + 1;
        } else {
            $number = 10001;
        }

        return 'invoices-' . $number;
    }
    public function quickForm()
{
    $sellers = Seller::all();
    $products = Product::with('category')->where('type', 'product')->get();
    $services = Product::with('category')->where('type', 'service')->get();
    $currencies = Currency::all();

    // شماره پیشنهادی برای فاکتور جدید
    $nextNumber = $this->generateNextInvoiceNumber();

    return view('sales.quick', compact(
        'sellers',
        'products',
        'services',
        'currencies',
        'nextNumber'
    ));
}
public function ajaxSearch(Request $request)
{
    $q = $request->input('q', '');
    $sales = Sale::where('invoice_number', 'like', "%$q%")
        ->orWhereHas('buyer', function($query) use ($q) {
            $query->where('name', 'like', "%$q%");
        })
        ->latest()
        ->limit(20)
        ->get();

    $data = $sales->map(function($sale) {
        return [
            'id' => $sale->id,
            'invoice_number' => $sale->invoice_number,
            'buyer' => optional($sale->buyer)->name ?? '-',
            'final_amount' => $sale->final_amount,
            'date' => jdate($sale->created_at)->format('Y/m/d'),
        ];
    });

    return response()->json($data);
}
public function ajaxShow(\App\Models\Sale $sale)
{
    $sale->load('items.product', 'items.service', 'buyer', 'seller');
    return response()->json([
        'id' => $sale->id,
        'invoice_number' => $sale->invoice_number,
        'buyer' => optional($sale->buyer)->name ?? '-',
        'seller' => optional($sale->seller)->first_name . ' ' . optional($sale->seller)->last_name,
        'final_amount' => number_format($sale->final_amount),
        'created_at' => jdate($sale->created_at)->format('Y/m/d'),
        'items' => $sale->items->map(function($item){
            return [
                'id' => $item->id,
                'name' => $item->product ? $item->product->name : ($item->service ? $item->service->name : '-'),
                'qty' => $item->quantity,
                'unit_price' => number_format($item->unit_price),
                'total' => number_format($item->total),
                'is_product' => $item->product_id ? true : false,
                'is_service' => $item->service_id ? true : false,
            ];
        }),
    ]);
}



    // متد فروش سریع

    public function quickStore(Request $request)
    {
        // اگر customer_id وجود ندارد، مشتری حضوری را پیدا یا ایجاد کن
        if (!$request->has('customer_id') || empty($request->customer_id)) {
            // مشتری حضوری را پیدا کن یا بساز
            $customer = Person::firstOrCreate(
                ['first_name' => 'مشتری', 'last_name' => 'حضوری'],
                ['mobile' => null]
            );
            $customer_id = $customer->id;
        } else {
            $customer_id = $request->customer_id;
        }

        $request->merge(['customer_id' => $customer_id]);

        $request->validate([
            'seller_id'      => 'required|exists:sellers,id',
            'currency_id'    => 'required|exists:currencies,id',
            'products_input' => 'required',
        ], [
            'seller_id.required'      => 'انتخاب فروشنده الزامی است.',
            'currency_id.required'    => 'انتخاب واحد پول الزامی است.',
            'products_input.required' => 'حداقل یک محصول یا خدمت به فاکتور اضافه کنید.',
        ]);

        $items = json_decode($request->products_input, true);
        if (empty($items)) {
            return back()->withInput()->withErrors(['products' => 'هیچ محصولی انتخاب نشده است.']);
        }

        DB::beginTransaction();
        try {
            $totalPrice = 0;
            $totalDiscount = 0;
            $totalTax = 0;

            foreach ($items as $item) {
                $count = isset($item['count']) ? intval($item['count']) : 0;
                $unitPrice = isset($item['sell_price']) ? intval($item['sell_price']) : 0;
                $discount = isset($item['discount']) ? floatval($item['discount']) : 0;
                $tax = isset($item['tax']) ? floatval($item['tax']) : 0;

                $subtotal = $count * $unitPrice;
                $itemDiscount = $discount;
                $itemTax = ($subtotal - $itemDiscount) * ($tax / 100);

                $totalPrice += $subtotal;
                $totalDiscount += $itemDiscount;
                $totalTax += $itemTax;

                $product = Product::find($item['id']);
                if ($product && $product->type === 'product') {
                    if ($product->stock < $count) {
                        throw new \Exception("موجودی محصول '{$product->name}' کافی نیست.");
                    }
                    $product->stock -= $count;
                    $product->save();
                }
            }

            $finalAmount = $totalPrice - $totalDiscount + $totalTax;
            $invoice_number = $this->generateNextInvoiceNumber();

            $sale = Sale::create([
                'invoice_number' => $invoice_number,
                'reference'      => $request->reference,
                'customer_id'    => $customer_id,
                'seller_id'      => $request->seller_id,
                'currency_id'    => $request->currency_id,
                'title'          => $request->title ?? 'فروش سریع',
                'issued_at'      => Carbon::now(),
                'total_price'    => $totalPrice,
                'discount'       => $totalDiscount,
                'tax'            => $totalTax,
                'final_amount'   => $finalAmount,
                'status'         => 'pending'
            ]);

            foreach ($items as $item) {
                $count = isset($item['count']) ? intval($item['count']) : 0;
                $unitPrice = isset($item['sell_price']) ? intval($item['sell_price']) : 0;
                $discount = isset($item['discount']) ? floatval($item['discount']) : 0;
                $tax = isset($item['tax']) ? floatval($item['tax']) : 0;

                $subtotal = $count * $unitPrice;
                $itemDiscount = $discount;
                $itemTax = ($subtotal - $itemDiscount) * ($tax / 100);
                $total = $subtotal - $itemDiscount + $itemTax;

                SaleItem::create([
                    'sale_id'     => $sale->id,
                    'product_id'  => $item['id'],
                    'quantity'    => $count,
                    'unit_price'  => $unitPrice,
                    'discount'    => $itemDiscount,
                    'tax'         => $itemTax,
                    'total'       => $total,
                    'description' => $item['desc'] ?? '',
                    'unit'        => $item['unit'] ?? '',
                ]);
            }

            $sale->calculateTotals();

            DB::commit();
            return redirect()->route('sales.index')->with('success', 'فروش سریع با موفقیت ثبت شد.');
        } catch (\Exception $ex) {
            DB::rollBack();
            return back()->withInput()->withErrors(['error' => $ex->getMessage()]);
        }
    }
}
