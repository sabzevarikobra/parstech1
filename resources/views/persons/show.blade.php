@extends('layouts.app')

@section('title', 'جزئیات ' . $person->full_name)

@push('styles')
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css">
<style>
.info-card {
    background: #fff;
    border-radius: 15px;
    box-shadow: 0 2px 15px rgba(0,0,0,0.05);
    padding: 20px;
    margin-bottom: 20px;
    transition: all 0.3s ease;
}

.info-card:hover {
    box-shadow: 0 5px 20px rgba(0,0,0,0.1);
}

.status-badge {
    padding: 5px 15px;
    border-radius: 20px;
    font-size: 0.9rem;
}

.chart-container {
    position: relative;
    height: 300px;
    margin-bottom: 20px;
}

.transactions-table th {
    background: #f8f9fc;
}

.kpi-card {
    text-align: center;
    padding: 15px;
    border-radius: 10px;
    background: linear-gradient(45deg, #f8f9fa, #ffffff);
    border: 1px solid #e9ecef;
}

.kpi-card .value {
    font-size: 24px;
    font-weight: bold;
    margin: 10px 0;
}

.timeline {
    position: relative;
    padding: 20px 0;
}

.timeline-item {
    padding: 15px;
    border-right: 2px solid #e9ecef;
    position: relative;
    margin-bottom: 15px;
}

.timeline-item::before {
    content: '';
    position: absolute;
    right: -9px;
    top: 20px;
    width: 16px;
    height: 16px;
    border-radius: 50%;
    background: #fff;
    border: 2px solid #4e73df;
}

.tab-content {
    background: #fff;
    border-radius: 0 0 15px 15px;
    padding: 20px;
    box-shadow: 0 2px 15px rgba(0,0,0,0.05);
}
</style>
@endpush

@section('content')
<div class="container-fluid">
    <!-- پیام‌های سیستم -->
    @if(session('success'))
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            {{ session('success') }}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    @endif

    @if(session('error'))
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            {{ session('error') }}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    @endif

    <!-- سربرگ صفحه -->
    <div class="page-header mb-4">
        <div class="d-flex justify-content-between align-items-center">
            <div>
                <h1 class="h3 mb-0 text-gray-800">
                    {{ $person->full_name }}
                    <span class="badge bg-{{ $person->type == 'shareholder' ? 'primary' : 'danger' }}">
                        {{ $person->type == 'shareholder' ? 'سهامدار' : 'مشتری' }}
                    </span>
                </h1>
                <p class="text-muted mb-0">
                    <i class="fas fa-fingerprint me-1"></i>
                    کد: {{ $person->accounting_code }}
                </p>
            </div>
            <div class="text-muted">
                <small>
                    <i class="fas fa-clock me-1"></i>
                    {{ jdate(now())->format('Y/m/d H:i:s') }}
                </small>
                <br>
                <small>
                    <i class="fas fa-user me-1"></i>
                    {{ auth()->user()->name }}
                </small>
            </div>
        </div>
    </div>

    <!-- شاخص‌های کلیدی -->
    <div class="row mb-4">
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="kpi-card">
                <div class="text-primary">
                    <i class="fas fa-shopping-cart fa-2x"></i>
                </div>
                <div class="value">{{ number_format($totalPurchases) }}</div>
                <div class="text-muted">تعداد کل خرید</div>
            </div>
        </div>
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="kpi-card">
                <div class="text-success">
                    <i class="fas fa-money-bill fa-2x"></i>
                </div>
                <div class="value">{{ number_format($totalAmount) }} تومان</div>
                <div class="text-muted">مجموع خرید</div>
            </div>
        </div>
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="kpi-card">
                <div class="text-info">
                    <i class="fas fa-calculator fa-2x"></i>
                </div>
                <div class="value">{{ $averageOrderValue ? number_format($averageOrderValue) : 0 }} تومان</div>
                <div class="text-muted">میانگین خرید</div>
            </div>
        </div>
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="kpi-card">
                <div class="text-{{ $person->balance >= 0 ? 'success' : 'danger' }}">
                    <i class="fas fa-wallet fa-2x"></i>
                </div>
                <div class="value">{{ number_format(abs($person->balance)) }} تومان</div>
                <div class="text-muted">{{ $person->balance >= 0 ? 'بستانکار' : 'بدهکار' }}</div>
            </div>
        </div>
    </div>

    <!-- نمودارها و آمار -->
    <div class="row mb-4">
        <div class="col-xl-8">
            <div class="info-card">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="mb-0">روند خرید</h5>
                    <select class="form-select" style="width: auto" id="purchaseTrendPeriod">
                        <option value="week">هفته گذشته</option>
                        <option value="month" selected>ماه گذشته</option>
                        <option value="year">سال گذشته</option>
                    </select>
                </div>
                <div class="chart-container">
                    <canvas id="purchasesTrendChart"></canvas>
                </div>
            </div>
        </div>
        <div class="col-xl-4">
            <div class="info-card">
                <h5 class="mb-3">محصولات پرخرید</h5>
                <div class="chart-container">
                    <canvas id="topProductsChart"></canvas>
                </div>
            </div>
        </div>
    </div>

    <!-- تب‌ها -->
    <ul class="nav nav-tabs" role="tablist">
        <li class="nav-item">
            <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#transactions">
                <i class="fas fa-history me-1"></i>
                تراکنش‌ها
            </button>
        </li>
        <li class="nav-item">
            <button class="nav-link" data-bs-toggle="tab" data-bs-target="#products">
                <i class="fas fa-box me-1"></i>
                محصولات
            </button>
        </li>
        <li class="nav-item">
            <button class="nav-link" data-bs-toggle="tab" data-bs-target="#payments">
                <i class="fas fa-money-check me-1"></i>
                پرداخت‌ها
            </button>
        </li>
        <li class="nav-item">
            <button class="nav-link" data-bs-toggle="tab" data-bs-target="#notes">
                <i class="fas fa-sticky-note me-1"></i>
                یادداشت‌ها
            </button>
        </li>
    </ul>

    <div class="tab-content">
        <!-- تب تراکنش‌ها -->
        <div class="tab-pane fade show active" id="transactions">
            <div class="card">
                <div class="card-body">
                    <!-- فیلترها -->
                    <div class="row g-3 mb-4">
                        <div class="col-md-3">
                            <input type="text" class="form-control" id="transaction-search" placeholder="جستجو در فاکتورها...">
                        </div>
                        <div class="col-md-3">
                            <input type="text" class="form-control daterange" placeholder="بازه زمانی">
                        </div>
                        <div class="col-md-2">
                            <select class="form-select" id="status-filter">
                                <option value="">همه وضعیت‌ها</option>
                                <option value="paid">پرداخت شده</option>
                                <option value="pending">در انتظار پرداخت</option>
                                <option value="cancelled">لغو شده</option>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <button class="btn btn-primary w-100" id="filter-transactions">
                                <i class="fas fa-search me-1"></i>
                                جستجو
                            </button>
                        </div>
                    </div>

                    <!-- جدول تراکنش‌ها -->
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead>
                                <tr>
                                    <th>شماره فاکتور</th>
                                    <th>تاریخ</th>
                                    <th>وضعیت</th>
                                    <th>مبلغ کل</th>
                                    <th>پرداخت شده</th>
                                    <th>مانده</th>
                                    <th>عملیات</th>
                                </tr>
                            </thead>
                            <tbody>
                                @foreach($sales as $sale)
                                <tr>
                                    <td>
                                        <a href="{{ route('sales.show', $sale) }}" class="text-decoration-none">
                                            {{ $sale->invoice_number }}
                                        </a>
                                    </td>
                                    <td>{{ jdate($sale->created_at)->format('Y/m/d H:i') }}</td>
                                    <td>
                                        <span class="badge bg-{{ $sale->status == 'paid' ? 'success' :
                                            ($sale->status == 'pending' ? 'warning' : 'danger') }}">
                                            {{ $sale->status == 'paid' ? 'پرداخت شده' :
                                               ($sale->status == 'pending' ? 'در انتظار پرداخت' : 'لغو شده') }}
                                        </span>
                                    </td>
                                    <td>{{ number_format($sale->total_amount) }} تومان</td>
                                    <td>{{ number_format($sale->paid_amount) }} تومان</td>
                                    <td>
                                        @if($sale->remaining_amount > 0)
                                            <span class="text-danger">
                                                {{ number_format($sale->remaining_amount) }} تومان
                                            </span>
                                        @else
                                            <span class="text-success">تسویه شده</span>
                                        @endif
                                    </td>
                                    <td>
                                        <div class="btn-group">
                                            <a href="{{ route('sales.show', $sale) }}"
                                               class="btn btn-sm btn-outline-primary"
                                               data-bs-toggle="tooltip"
                                               title="مشاهده">
                                                <i class="fas fa-eye"></i>
                                            </a>
                                            <button type="button"
                                                    class="btn btn-sm btn-outline-success"
                                                    onclick="showPaymentModal({{ $sale->id }})"
                                                    data-bs-toggle="tooltip"
                                                    title="ثبت پرداخت">
                                                <i class="fas fa-money-bill"></i>
                                            </button>
                                            <a href="{{ route('sales.print', $sale) }}"
                                               class="btn btn-sm btn-outline-info"
                                               target="_blank"
                                               data-bs-toggle="tooltip"
                                               title="چاپ">
                                                <i class="fas fa-print"></i>
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                                @endforeach
                            </tbody>
                        </table>
                    </div>

                    <!-- Pagination -->
                    <div class="d-flex justify-content-center mt-4">
                        {{ $sales->links() }}
                    </div>
                </div>
            </div>
        </div>

        <!-- تب محصولات -->
        <div class="tab-pane fade" id="products">
            <div class="row">
                <div class="col-md-8">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title mb-3">محصولات خریداری شده</h5>
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th>محصول</th>
                                            <th>تعداد خرید</th>
                                            <th>آخرین خرید</th>
                                            <th>مجموع مبلغ</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        @foreach($topProducts as $product)
                                        <tr>
                                            <td>{{ $product->name }}</td>
                                            <td>{{ $product->purchase_count }}</td>
                                            <td>{{ jdate($product->last_purchase)->format('Y/m/d') }}</td>
                                            <td>{{ number_format($product->total_amount) }} تومان</td>
                                        </tr>
                                        @endforeach
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="info-card">
                        <h5 class="mb-3">آمار محصولات</h5>
                        <div class="d-flex flex-column gap-3">
                            <div class="d-flex justify-content-between align-items-center">
                                <span>تعداد محصولات متمایز:</span>
                                <strong>{{ $uniqueProducts }}</strong>
                            </div>
                            @if($mostBoughtProduct)
                            <div class="d-flex justify-content-between align-items-center">
                                <span>محصول پرتکرار:</span>
                                <strong>{{ $mostBoughtProduct->name }}</strong>
                            </div>
                            @endif
                            <div class="d-flex justify-content-between align-items-center">
                                <span>بیشترین مبلغ خرید:</span>
                                <strong>{{ number_format($highestPurchase) }} تومان</strong>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- تب پرداخت‌ها -->
        <div class="tab-pane fade" id="payments">
            <div class="row">
                <div class="col-md-8">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title mb-3">تاریخچه پرداخت</h5>
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>تاریخ</th>
                                            <th>روش پرداخت</th>
                                            <th>مبلغ</th>
                                            <th>وضعیت</th>
                                            <th>توضیحات</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        @foreach($payments as $payment)
                                        <tr>
                                            <td>{{ jdate($payment->paid_at)->format('Y/m/d') }}</td>
                                            <td>
                                                @switch($payment->method)
                                                    @case('cash')
                                                        نقدی
                                                        @break
                                                    @case('card')
                                                        کارت به کارت
                                                        @break
                                                    @case('cheque')
                                                        چک
                                                        @break
                                                    @default
                                                        {{ $payment->method }}
                                                @endswitch
                                            </td>
                                            <td>{{ number_format($payment->amount) }} تومان</td>
                                            <td>
                                                <span class="badge bg-{{ $payment->status == 'success' ? 'success' : 'warning' }}">
                                                    {{ $payment->status == 'success' ? 'موفق' : 'در انتظار تایید' }}
                                                </span>
                                            </td>
                                            <td>{{ $payment->description }}</td>
                                        </tr>
                                        @endforeach
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="info-card">
                        <h5 class="mb-3">وضعیت پرداخت</h5>
                        <div class="d-flex flex-column gap-3">
                            <div class="d-flex justify-content-between align-items-center">
                                <span>کل بدهی:</span>
                                <strong class="text-danger">
                                    {{ number_format($totalDebt) }} تومان
                                </strong>
                            </div>
                            <div class="d-flex justify-content-between align-items-center">
                                <span>کل پرداختی:</span>
                                <strong class="text-success">
                                    {{ number_format($totalPaid) }} تومان
                                </strong>
                            </div>
                            <div class="d-flex justify-content-between align-items-center">
                                <span>مانده حساب:</span>
                                <strong class="text-{{ $balance >= 0 ? 'success' : 'danger' }}">
                                    {{ number_format(abs($balance)) }} تومان
                                    {{ $balance >= 0 ? 'بستانکار' : 'بدهکار' }}
                                </strong>
                            </div>
                        </div>

                        @if(count($pendingCheques) > 0)
                        <hr>
                        <h6 class="mb-3">چک‌های در جریان</h6>
                        <div class="timeline">
                            @foreach($pendingCheques as $cheque)
                            <div class="timeline-item">
                                <div class="d-flex justify-content-between">
                                    <span>{{ number_format($cheque->amount) }} تومان</span>
                                    <small>{{ jdate($cheque->due_date)->format('Y/m/d') }}</small>
                                </div>
                                <small class="text-muted d-block">
                                    {{ $cheque->bank }} - {{ $cheque->number }}
                                </small>
                            </div>
                            @endforeach
                        </div>
                        @endif
                    </div>
                </div>
            </div>
        </div>

        <!-- تب یادداشت‌ها -->
        <div class="tab-pane fade" id="notes">
            <div class="row">
                <div class="col-md-8">
                    <div class="timeline">
                        @if(count($notes) > 0)
                            @foreach($notes as $note)
                            <div class="timeline-item">
                                <div class="d-flex justify-content-between mb-2">
                                    <strong>{{ $note->user->name }}</strong>
                                    <small class="text-muted">
                                        {{ jdate($note->created_at)->ago() }}
                                    </small>
                                </div>
                                <p class="mb-0">{{ $note->content }}</p>
                            </div>
                            @endforeach
                        @else
                            <p class="text-muted">هیچ یادداشتی ثبت نشده است.</p>
                        @endif
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="info-card">
                        <h5 class="mb-3">افزودن یادداشت جدید</h5>
                        <form action="{{ route('person.notes.store', $person) }}" method="POST">
                            @csrf
                            <div class="mb-3">
                                <textarea name="content" rows="3" class="form-control @error('content') is-invalid @enderror"
                                          placeholder="یادداشت خود را بنویسید...">{{ old('content') }}</textarea>
                                @error('content')
                                    <div class="invalid-feedback">{{ $message }}</div>
                                @enderror
                            </div>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-plus me-1"></i>
                                افزودن یادداشت
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- مودال پرداخت -->
<div class="modal fade" id="paymentModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">ثبت پرداخت جدید</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form action="{{ route('payments.store') }}" method="POST" id="payment-form">
                @csrf
                <input type="hidden" name="sale_id" id="payment-sale-id">
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">مبلغ (تومان)</label>
                        <input type="number" name="amount" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">روش پرداخت</label>
                        <select name="method" class="form-select" required>
                            <option value="cash">نقدی</option>
                            <option value="card">کارت به کارت</option>
                            <option value="cheque">چک</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">توضیحات</label>
                        <textarea name="description" class="form-control" rows="2"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">انصراف</button>
                    <button type="submit" class="btn btn-primary">ثبت پرداخت</button>
                </div>
            </form>
        </div>
    </div>
</div>
@endsection

@push('scripts')
<script src="https://cdn.jsdelivr.net/npm/moment-jalaali@0.9.2/build/moment-jalaali.js"></script>
<script src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>

<!-- Import از node_modules -->
<script src="{{ asset('node_modules/chart.js/dist/chart.umd.js') }}"></script>
<!-- یا اگر از vite استفاده می‌کنید -->
@vite(['node_modules/chart.js/dist/chart.umd.js'])
<script>
    // تنظیمات Chart.js با آخرین نسخه
    const config = {
        plugins: {
            colors: {
                enabled: true
            }
        }
    };

    Chart.defaults.set('plugins.colors', {
        enabled: true
    });

    Chart.defaults.font.family = 'IRANSans';
    Chart.defaults.color = '#666';
    Chart.defaults.responsive = true;
    Chart.defaults.maintainAspectRatio = false;

    // نمودار روند خرید
    const purchasesTrendCtx = document.getElementById('purchasesTrendChart').getContext('2d');
    new Chart(purchasesTrendCtx, {
        type: 'line',
        data: {
            labels: @json($purchasesTrendLabels),
            datasets: [{
                label: 'مبلغ خرید',
                data: @json($purchasesTrendData),
                borderColor: '#4e73df',
                backgroundColor: 'rgba(78, 115, 223, 0.2)',
                fill: true,
                tension: 0.4,
                pointStyle: 'circle',
                pointRadius: 4,
                pointHoverRadius: 6
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            interaction: {
                mode: 'index',
                intersect: false,
            },
            plugins: {
                legend: {
                    display: false
                },
                tooltip: {
                    rtl: true,
                    titleAlign: 'right',
                    textDirection: 'rtl',
                    bodyAlign: 'right',
                    callbacks: {
                        label: function(context) {
                            let label = context.dataset.label || '';
                            if (label) {
                                label += ': ';
                            }
                            if (context.parsed.y !== null) {
                                label += new Intl.NumberFormat('fa-IR').format(context.parsed.y) + ' تومان';
                            }
                            return label;
                        }
                    }
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        callback: function(value) {
                            return new Intl.NumberFormat('fa-IR').format(value) + ' تومان';
                        }
                    }
                }
            }
        }
    });

    // نمودار محصولات پرخرید
    const topProductsCtx = document.getElementById('topProductsChart').getContext('2d');
    new Chart(topProductsCtx, {
        type: 'doughnut',
        data: {
            labels: @json($topProductsLabels),
            datasets: [{
                data: @json($topProductsData),
                backgroundColor: [
                    'rgba(78, 115, 223, 0.8)',
                    'rgba(28, 200, 138, 0.8)',
                    'rgba(54, 185, 204, 0.8)',
                    'rgba(246, 194, 62, 0.8)',
                    'rgba(231, 74, 59, 0.8)'
                ],
                borderWidth: 1,
                borderColor: '#ffffff'
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    position: 'bottom',
                    rtl: true,
                    labels: {
                        usePointStyle: true,
                        padding: 20,
                        font: {
                            size: 12
                        }
                    }
                },
                tooltip: {
                    rtl: true,
                    titleAlign: 'right',
                    textDirection: 'rtl',
                    bodyAlign: 'right'
                }
            },
            cutout: '60%',
            radius: '90%'
        }
    });

    // تابع فرمت‌بندی اعداد
    function number_format(number) {
        return new Intl.NumberFormat('fa-IR').format(number);
    }

    // نمایش مودال پرداخت
    function showPaymentModal(saleId) {
        document.getElementById('payment-sale-id').value = saleId;
        new bootstrap.Modal(document.getElementById('paymentModal')).show();
    }

    // تنظیمات Date Range Picker
    $('.daterange').daterangepicker({
        locale: {
            format: 'jYYYY/jMM/jDD',
            separator: ' - ',
            applyLabel: 'اعمال',
            cancelLabel: 'انصراف',
            fromLabel: 'از',
            toLabel: 'تا',
            customRangeLabel: 'بازه دلخواه',
            weekLabel: 'هفته',
            daysOfWeek: ['ی', 'د', 'س', 'چ', 'پ', 'ج', 'ش'],
            monthNames: [
                'فروردین', 'اردیبهشت', 'خرداد', 'تیر', 'مرداد', 'شهریور',
                'مهر', 'آبان', 'آذر', 'دی', 'بهمن', 'اسفند'
            ],
            firstDay: 6
        },
        startDate: moment().subtract(29, 'days'),
        endDate: moment(),
        ranges: {
            'امروز': [moment(), moment()],
            'دیروز': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
            '۷ روز اخیر': [moment().subtract(6, 'days'), moment()],
            '۳۰ روز اخیر': [moment().subtract(29, 'days'), moment()],
            'این ماه': [moment().startOf('month'), moment().endOf('month')],
            'ماه قبل': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
        }
    });

    // فعال‌سازی تولتیپ‌ها
    const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
    const tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl)
    });
    </script>
    @endpush
