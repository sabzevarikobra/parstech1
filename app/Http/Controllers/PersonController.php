<?php

namespace App\Http\Controllers;

use Morilog\Jalali\Jalalian;
use App\Models\Person;
use Illuminate\Http\Request;
use Exception;
use App\Models\Product;
use Illuminate\Support\Facades\DB;
use App\Models\Province;
use App\Models\CustomerPurchase;

class PersonController extends Controller
{

    public function getCities($province_id)
    {
        try {
            $cities = \App\Models\City::where('province_id', $province_id)
                ->select('id', 'name')
                ->orderBy('name')
                ->get()
                ->map(function($city) {
                    return [
                        'id' => $city->id,
                        'text' => $city->name
                    ];
                });

            return response()->json($cities);
        } catch (\Exception $e) {
            return response()->json(['error' => 'خطا در دریافت شهرها'], 500);
        }
    }
    public function nextCode()
    {
        try {
            $lastPerson = Person::where('accounting_code', 'like', 'persons=%')
                ->orderByRaw('CAST(SUBSTRING(accounting_code, 9) AS UNSIGNED) DESC')
                ->first();

            $nextNumber = 1001; // شماره پیش‌فرض

            if ($lastPerson && preg_match('/^persons=-(\d+)$/', $lastPerson->accounting_code, $matches)) {
                $nextNumber = intval($matches[1]) + 1;
            }

            $nextCode = 'persons=-' . $nextNumber;

            return response()->json([
                'success' => true,
                'code' => $nextCode
            ]);
        } catch (\Exception $e) {
            \Log::error('Error generating next code: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'خطا در تولید کد حسابداری',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function index(Request $request)
{
    // Query Builder اصلی
    $query = Person::query();

    // جستجو
    if ($request->filled('search')) {
        $search = $request->search;
        $query->where(function($q) use ($search) {
            $q->where('first_name', 'like', "%{$search}%")
              ->orWhere('last_name', 'like', "%{$search}%")
              ->orWhere('company_name', 'like', "%{$search}%")
              ->orWhere('mobile', 'like', "%{$search}%")
              ->orWhere('accounting_code', 'like', "%{$search}%");
        });
    }

    // فیلتر نوع
    if ($request->filled('type')) {
        $query->where('type', $request->type);
    }

    // فیلتر وضعیت
    if ($request->filled('status')) {
        $query->where('status', $request->status);
    }

    // فیلتر تاریخ
    if ($request->filled('date_range')) {
        $dates = explode(' - ', $request->date_range);
        if (count($dates) == 2) {
            try {
                $start = \Carbon\Carbon::createFromFormat('Y/m/d', trim($dates[0]))->startOfDay();
                $end = \Carbon\Carbon::createFromFormat('Y/m/d', trim($dates[1]))->endOfDay();
                $query->whereBetween('created_at', [$start, $end]);
            } catch (\Exception $e) {
                // در صورت خطا در تاریخ، فیلتر را نادیده بگیر
            }
        }
    }

    // آمار کلی
    $totalPersons = Person::count();
    $totalTransactions = Person::sum('total_sales'); // یا هر فیلد دیگری که مجموع معاملات رو نشون میده
    $activeCustomers = Person::where('type', 'customer')
                           ->where('status', 'active')
                           ->count();
    $debtorsCount = Person::where('balance', '<', 0)->count();

    // دریافت لیست اشخاص با اطلاعات مالی
    $persons = $query->latest()
                    ->paginate(10)
                    ->through(function ($person) {
                        // محاسبه نام کامل و سایر محاسبات مورد نیاز
                        return $person;
                    });

    return view('persons.index', compact(
        'persons',
        'totalPersons',
        'totalTransactions',
        'activeCustomers',
        'debtorsCount'
    ));
}

    public function create()
    {
        $provinces = Province::all();
        // کد پیش‌فرض برای فرم (برای نمایش اولیه)
        // فقط کدهایی که با persons=- شروع می‌شوند را درنظر بگیر
        $lastPerson = Person::where('accounting_code', 'like', 'persons=%')
            ->orderByRaw('CAST(SUBSTRING(accounting_code, 9) AS UNSIGNED) DESC')
            ->first();

        if ($lastPerson && preg_match('/^persons=-(\d+)$/', $lastPerson->accounting_code, $matches)) {
            $nextNumber = intval($matches[1]) + 1;
        } else {
            $nextNumber = 1001;
        }
        $defaultCode = 'persons=-' . $nextNumber;

        return view('persons.create', compact('provinces', 'defaultCode'));
    }

    public function store(Request $request)
    {

        \Log::info('DATE_INPUTS', [
            'birth_date' => $request->birth_date,
            'marriage_date' => $request->marriage_date,
            'join_date' => $request->join_date,
        ]);

        // تبدیل تاریخ شمسی به میلادی
        foreach (['join_date', 'birth_date', 'marriage_date'] as $dateField) {
            if ($request->has($dateField) && $request->$dateField) {
                try {
                    if (strpos($request->$dateField, '-') !== false) {
                        $request[$dateField] = Jalalian::fromFormat('Y-m-d', $request->$dateField)->toCarbon()->toDateString();
                    } elseif (strpos($request->$dateField, '/') !== false) {
                        $request[$dateField] = Jalalian::fromFormat('Y/m/d', $request->$dateField)->toCarbon()->toDateString();
                    }
                } catch (\Exception $e) {
                    $request[$dateField] = null;
                }
            }
        }

        $rules = [
            'accounting_code' => 'required|string|unique:persons,accounting_code',
            'type' => 'required|in:customer,supplier,shareholder,employee',
            'province' => 'required|exists:provinces,id',
            'city' => 'required|exists:cities,id',
            'address' => 'required|string',
            'country' => 'required|string',
        ];

        if ($request->input('type') == 'supplier') {
            $rules['company_name'] = 'required|string';
        } else {
            $rules['first_name'] = 'required|string';
            $rules['last_name'] = 'required|string';
        }

        $optionalFields = [
            'nickname', 'credit_limit', 'price_list', 'tax_type', 'national_code', 'economic_code',
            'registration_number', 'branch_code', 'description', 'postal_code', 'phone', 'mobile', 'fax',
            'phone1', 'phone2', 'phone3', 'email', 'website', 'birth_date', 'marriage_date', 'join_date',
            'company_name', 'title'
        ];
        foreach ($optionalFields as $field) {
            $rules[$field] = 'nullable';
        }

        $validated = $request->validate($rules);

        try {
            DB::beginTransaction();

            // اگر کد خودکار فعال است و کاربر دستی کد نداده، دوباره از دیتابیس بگیر
            if ($request->input('auto_code', '1') === '1') {
                $lastPerson = Person::where('accounting_code', 'like', 'persons=%')
                    ->orderByRaw('CAST(SUBSTRING(accounting_code, 9) AS UNSIGNED) DESC')
                    ->first();

                if ($lastPerson && preg_match('/^persons=-(\d+)$/', $lastPerson->accounting_code, $matches)) {
                    $nextNumber = intval($matches[1]) + 1;
                } else {
                    $nextNumber = 1001;
                }
                $request->merge(['accounting_code' => 'persons=-' . $nextNumber]);
            }

            $person = Person::create($request->all());

            // ذخیره حساب‌های بانکی (اگر ارسال شده)
            if ($request->has('bank_accounts')) {
                $bankAccounts = [];
                foreach ($request->bank_accounts as $account) {
                    if (!empty($account['bank_name'])) {
                        $bankAccounts[] = [
                            'bank_name' => $account['bank_name'],
                            'branch' => $account['branch'] ?? null,
                            'account_number' => $account['account_number'] ?? null,
                            'card_number' => $account['card_number'] ?? null,
                            'iban' => $account['iban'] ?? null,
                        ];
                    }
                }
                if (!empty($bankAccounts)) {
                    $person->bankAccounts()->createMany($bankAccounts);
                }
            }

            DB::commit();
            return redirect()->route('persons.index')->with('success', 'شخص جدید با موفقیت ایجاد شد.');
        } catch (\Exception $e) {
            DB::rollBack();
            return back()->withInput()->withErrors(['error' => $e->getMessage()]);
        }
    }

    public function show(Person $person)
    {
        // آمار کلی به تفکیک محصولات و خدمات
        $productStats = $person->sales()
        ->join('sale_items', 'sales.id', '=', 'sale_items.sale_id')
        ->join('products', 'sale_items.product_id', '=', 'products.id')
        ->where('products.type', 'product')
        ->selectRaw('
            SUM(sale_items.quantity * sale_items.unit_price) as total_amount,
            COUNT(DISTINCT sales.id) as purchase_count,
            SUM(sales.paid_amount) as paid_amount
        ')
        ->first();

        $serviceStats = $person->sales()
        ->join('sale_items', 'sales.id', '=', 'sale_items.sale_id')
        ->join('products', 'sale_items.product_id', '=', 'products.id')
        ->where('products.type', 'service')
        ->selectRaw('
            SUM(sale_items.quantity * sale_items.unit_price) as total_amount,
            COUNT(DISTINCT sales.id) as purchase_count,
            SUM(sales.paid_amount) as paid_amount
        ')
        ->first();

            // روند خرید در بازه‌های مختلف
        $periods = [
            '5_days' => now()->subDays(5),
            '1_month' => now()->subMonth(),
            '3_months' => now()->subMonths(3),
            '6_months' => now()->subMonths(6),
            '1_year' => now()->subYear()
        ];

        $purchaseTrends = [];
        foreach ($periods as $key => $startDate) {
            $trend = $person->sales()
                ->where('created_at', '>=', $startDate)
                ->selectRaw('
                    DATE(created_at) as date,
                    SUM(final_amount) as total_amount,
                    SUM(paid_amount) as paid_amount
                ')
                ->groupBy('date')
                ->get();

            $purchaseTrends[$key] = [
                'labels' => $trend->pluck('date')->map(function($date) {
                    return jdate($date)->format('Y/m/d');
                }),
                'amounts' => [
                    'total' => $trend->pluck('total_amount'),
                    'paid' => $trend->pluck('paid_amount')
                ]
            ];
        }

        // محصولات و خدمات پرفروش به تفکیک
        $topProducts = $person->sales()
        ->join('sale_items', 'sales.id', '=', 'sale_items.sale_id')
        ->join('products', 'sale_items.product_id', '=', 'products.id')
        ->where('products.type', 'product')
        ->selectRaw('
            products.id,
            products.name,
            SUM(sale_items.quantity) as total_quantity,
            SUM(sale_items.quantity * sale_items.unit_price) as total_amount,
            COUNT(DISTINCT sales.id) as purchase_count,
            MAX(sales.created_at) as last_purchase
        ')
        ->groupBy('products.id', 'products.name')
        ->orderBy('total_amount', 'desc')
        ->limit(5)
        ->get();

        $topServices = $person->sales()
        ->join('sale_items', 'sales.id', '=', 'sale_items.sale_id')
        ->join('products', 'sale_items.product_id', '=', 'products.id')
        ->where('products.type', 'service')
        ->selectRaw('
            products.id,
            products.name,
            SUM(sale_items.quantity) as total_quantity,
            SUM(sale_items.quantity * sale_items.unit_price) as total_amount,
            COUNT(DISTINCT sales.id) as purchase_count,
            MAX(sales.created_at) as last_purchase
        ')
        ->groupBy('products.id', 'products.name')
        ->orderBy('total_amount', 'desc')
        ->limit(5)
        ->get();

            // آمار کلی
        $totalStats = [
            'total_amount' => $productStats->total_amount + $serviceStats->total_amount,
            'total_paid' => $productStats->paid_amount + $serviceStats->paid_amount,
            'remaining' => ($productStats->total_amount + $serviceStats->total_amount) -
                        ($productStats->paid_amount + $serviceStats->paid_amount)
        ];

        return view('persons.show', compact(
            'person',
            'productStats',
            'serviceStats',
            'totalStats',
            'purchaseTrends',
            'topProducts',
            'topServices'
        ));

        // آمار کلی
        $totalPurchases = $person->sales()->count();
        $totalAmount = $person->sales()->sum('final_amount');
        $averageOrderValue = $totalPurchases > 0 ? $totalAmount / $totalPurchases : 0;

        // تراکنش‌ها با صفحه‌بندی
        $sales = $person->sales()
            ->with(['items.product'])
            ->latest()
            ->paginate(10);

        // نمودار روند خرید
        $purchasesTrend = $person->sales()
            ->where('created_at', '>=', now()->subMonth())
            ->selectRaw('DATE(created_at) as date, SUM(final_amount) as total')
            ->groupBy('date')
            ->get();

        $purchasesTrendLabels = $purchasesTrend->pluck('date')->map(function($date) {
            return jdate($date)->format('Y/m/d');
        });
        $purchasesTrendData = $purchasesTrend->pluck('total');

        // محصولات پرخرید
        $topProducts = $person->sales()
            ->join('sale_items', 'sales.id', '=', 'sale_items.sale_id')
            ->join('products', 'sale_items.product_id', '=', 'products.id')
            ->selectRaw('
                products.name,
                COUNT(*) as purchase_count,
                MAX(sales.created_at) as last_purchase,
                SUM(sale_items.quantity * sale_items.unit_price) as total_amount
            ')
            ->groupBy('products.id', 'products.name')
            ->orderBy('purchase_count', 'desc')
            ->limit(5)
            ->get();

        $topProductsLabels = $topProducts->pluck('name');
        $topProductsData = $topProducts->pluck('purchase_count');

        // آمار محصولات
        $uniqueProducts = $person->sales()
            ->join('sale_items', 'sales.id', '=', 'sale_items.sale_id')
            ->distinct('sale_items.product_id')
            ->count();

        $mostBoughtProduct = $topProducts->first();
        $highestPurchase = $topProducts->max('total_amount');

        // اطلاعات مالی
        $totalDebt = $person->sales()->sum('final_amount');
        $totalPaid = $person->sales()->sum('paid_amount');
        $balance = $totalPaid - $totalDebt;

        // چک‌های در جریان
        $pendingCheques = $person->sales()
            ->whereNotNull('cheque_number')
            ->where('cheque_status', 'pending')
            ->where('cheque_due_date', '>=', now())
            ->select(['cheque_amount as amount', 'cheque_due_date as due_date',
                     'cheque_number as number', 'cheque_bank as bank'])
            ->orderBy('cheque_due_date')
            ->get();

        // تاریخچه پرداخت‌ها
        $payments = $person->sales()
            ->whereNotNull('paid_at')
            ->select([
                'paid_at',
                'payment_method as method',
                'paid_amount as amount',
                'status',
                'payment_notes as description'
            ])
            ->orderBy('paid_at', 'desc')
            ->get();

        // یادداشت‌ها
        $notes = $person->notes()
            ->with('user')
            ->latest()
            ->get();

        // محاسبه فروشندگان مرتبط
        $relatedSellers = $person->sales()
            ->join('sellers', 'sales.seller_id', '=', 'sellers.id')
            ->selectRaw('
                sellers.id,
                sellers.first_name,
                sellers.last_name,
                COUNT(*) as sales_count,
                SUM(sales.final_amount) as total_amount
            ')
            ->groupBy('sellers.id', 'sellers.first_name', 'sellers.last_name')
            ->orderBy('sales_count', 'desc')
            ->get();

        // آخرین محصولات خریداری شده
        $recentProducts = $person->sales()
            ->join('sale_items', 'sales.id', '=', 'sale_items.sale_id')
            ->join('products', 'sale_items.product_id', '=', 'products.id')
            ->select([
                'products.id',
                'products.name',
                'sale_items.quantity',
                'sale_items.unit_price',
                'sales.created_at'
            ])
            ->latest('sales.created_at')
            ->limit(5)
            ->get();

        // پیشنهادات محصول
        $suggestedProducts = Product::whereIn('category_id', function($query) use ($person) {
            $query->select('products.category_id')
                ->from('products')
                ->join('sale_items', 'products.id', '=', 'sale_items.product_id')
                ->join('sales', 'sale_items.sale_id', '=', 'sales.id')
                ->where('sales.customer_id', $person->id)
                ->distinct();
        })
        ->whereNotIn('id', function($query) use ($person) {
            $query->select('sale_items.product_id')
                ->from('sale_items')
                ->join('sales', 'sale_items.sale_id', '=', 'sales.id')
                ->where('sales.customer_id', $person->id);
        })
        ->limit(5)
        ->get();

        // اطلاعات اعتباری
        $creditInfo = [
            'limit' => $person->credit_limit,
            'used' => $person->sales()->where('status', 'pending')->sum('remaining_amount'),
            'available' => max(0, $person->credit_limit - $person->sales()->where('status', 'pending')->sum('remaining_amount'))
        ];

        // محاسبه شاخص‌های کلیدی اضافی
        $kpis = [
            'return_rate' => $person->sales()->where('status', 'returned')->count() / max(1, $totalPurchases) * 100,
            'avg_payment_time' => $person->sales()
                ->whereNotNull('paid_at')
                ->avg(DB::raw('DATEDIFF(paid_at, created_at)')),
            'loyalty_score' => min(100, ($totalPurchases * 10) + ($totalAmount / 1000000))
        ];

        return view('persons.show', compact(
            'person',
            'totalPurchases',
            'totalAmount',
            'averageOrderValue',
            'sales',
            'purchasesTrendLabels',
            'purchasesTrendData',
            'topProducts',
            'topProductsLabels',
            'topProductsData',
            'uniqueProducts',
            'mostBoughtProduct',
            'highestPurchase',
            'totalDebt',
            'totalPaid',
            'balance',
            'pendingCheques',
            'payments',
            'notes',
            'relatedSellers',
            'recentProducts',
            'suggestedProducts',
            'creditInfo',
            'kpis'
        ));

        $notes = [];
        if (Schema::hasTable('notes')) {
            $notes = $person->notes()
                ->with('user')
                ->latest()
                ->get();
        }

    }
    public function updatePercent(Request $request, Person $person)
    {
        $request->validate([
            'purchase_percent' => 'required|numeric|min:0|max:100'
        ]);

        $person->update([
            'purchase_percent' => $request->purchase_percent
        ]);

        return back()->with('success', 'درصد سهم با موفقیت به‌روزرسانی شد.');
    }


    /**
     * این متد برای ذخیره یادداشت جدید برای شخص استفاده می‌شود
     */
    public function storeNote(Request $request, Person $person)
    {
        $request->validate([
            'content' => 'required|string|max:1000'
        ], [
            'content.required' => 'متن یادداشت الزامی است',
            'content.max' => 'متن یادداشت نمی‌تواند بیشتر از 1000 کاراکتر باشد'
        ]);

        try {
            $note = $person->notes()->create([
                'content' => $request->content,
                'user_id' => auth()->id()
            ]);

            return back()->with('success', 'یادداشت با موفقیت ثبت شد.');
        } catch (\Exception $e) {
            return back()->with('error', 'خطا در ثبت یادداشت: ' . $e->getMessage());
        }
    }

    public function salesStats(Person $person)
    {
        $stats = [
            'total_purchases' => $person->sales()->count(),
            'total_amount' => $person->sales()->sum('final_amount'),
            'average_purchase' => $person->sales()->avg('final_amount'),
            'last_purchase_date' => $person->sales()->latest()->first()?->created_at,
            'payment_status' => [
                'paid' => $person->sales()->where('status', 'paid')->count(),
                'pending' => $person->sales()->where('status', 'pending')->count(),
                'cancelled' => $person->sales()->where('status', 'cancelled')->count()
            ]
        ];

        return response()->json($stats);
    }

    /**
     * این متد برای دریافت محصولات پرفروش شخص در API استفاده می‌شود
     */
    public function topProducts(Person $person)
    {
        $products = $person->sales()
            ->join('sale_items', 'sales.id', '=', 'sale_items.sale_id')
            ->join('products', 'sale_items.product_id', '=', 'products.id')
            ->selectRaw('
                products.id,
                products.name,
                COUNT(*) as purchase_count,
                SUM(sale_items.quantity) as total_quantity,
                SUM(sale_items.quantity * sale_items.unit_price) as total_amount
            ')
            ->groupBy('products.id', 'products.name')
            ->orderBy('purchase_count', 'desc')
            ->limit(10)
            ->get();

        return response()->json($products);
    }











}
