@extends('layouts.app')

@section('title', 'لیست بدهکاران')

@push('styles')
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/datatables.net-bs5@2.0.8/css/dataTables.bootstrap5.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css">
<style>
    .person-detail-card { background:#fff; border-radius:12px; box-shadow:0 2px 15px rgba(0,0,0,0.07); padding:20px; }
</style>
@endpush

@section('content')
<div class="container-fluid py-4">
    <div class="row mb-4">
        <!-- آمار کلی بدهی -->
        <div class="col-lg-4 mb-3">
            <div class="card shadow p-4 text-center">
                <h4 class="mb-3">مجموع کل بدهی بدهکاران</h4>
                <div class="display-5 text-danger fw-bold" id="totalDebtAmount">{{ number_format($totalDebt) }} تومان</div>
                <div class="mt-3">
                    <canvas id="totalDebtPie" height="90"></canvas>
                </div>
                <div class="mt-3 text-muted">تعداد بدهکار: <span id="debtorsCount">{{ $debtorsCount }}</span> نفر</div>
            </div>
        </div>
        <!-- مجموع بدهی انتخابی -->
        <div class="col-lg-4 mb-3">
            <div class="card shadow p-4 text-center">
                <h6 class="mb-3">جمع بدهی انتخاب شده</h6>
                <div class="display-6 text-primary fw-bold" id="selectedDebtAmount">۰ تومان</div>
                <div class="mt-3">
                    <canvas id="selectedDebtPie" height="80"></canvas>
                </div>
                <div class="mt-3 text-muted">تعداد انتخاب شده: <span id="selectedCount">۰</span></div>
            </div>
        </div>
        <!-- اطلاعات شخص انتخاب شده -->
        <div class="col-lg-4 mb-3">
            <div class="person-detail-card text-center" id="personDetailCard" style="min-height: 180px;">
                <div class="text-muted">برای مشاهده اطلاعات، یک شخص را انتخاب کنید</div>
            </div>
        </div>
    </div>
    <!-- فیلتر -->
    <form class="mb-3" method="get" id="debtorsFilterForm">
        <div class="row g-2 align-items-center">
            <div class="col-md-2"><input name="search" type="text" class="form-control" placeholder="جستجو (نام، موبایل ...)" value="{{ request('search') }}"></div>
            <div class="col-md-2">
                <select name="type" class="form-select">
                    <option value="">همه انواع</option>
                    <option value="customer" {{ request('type')=='customer'?'selected':'' }}>مشتری</option>
                    <option value="supplier" {{ request('type')=='supplier'?'selected':'' }}>تامین‌کننده</option>
                    <option value="employee" {{ request('type')=='employee'?'selected':'' }}>کارمند</option>
                    <option value="shareholder" {{ request('type')=='shareholder'?'selected':'' }}>سهامدار</option>
                </select>
            </div>
            <div class="col-md-2">
                <select name="status" class="form-select">
                    <option value="">همه وضعیت‌ها</option>
                    <option value="active" {{ request('status')=='active'?'selected':'' }}>فعال</option>
                    <option value="inactive" {{ request('status')=='inactive'?'selected':'' }}>غیرفعال</option>
                </select>
            </div>
            <div class="col-md-3">
                <input name="date_range" type="text" class="form-control daterange" placeholder="بازه ثبت" value="{{ request('date_range') }}">
            </div>
            <div class="col-md-2">
                <button class="btn btn-outline-primary w-100" type="submit"><i class="fas fa-filter"></i> فیلتر</button>
            </div>
        </div>
    </form>
    <!-- جدول بدهکاران -->
    <div class="card shadow">
        <div class="card-body">
            <table class="table table-bordered table-hover align-middle" id="debtorsTable">
                <thead>
                    <tr>
                        <th><input type="checkbox" id="selectAllDebtors"></th>
                        <th>نام</th>
                        <th>موبایل</th>
                        <th>کد حسابداری</th>
                        <th>نوع</th>
                        <th>جمع بدهی</th>
                        <th>پرداخت شده</th>
                        <th>فروش</th>
                        <th>وضعیت</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach($debtors as $person)
                    <tr data-id="{{ $person->id }}">
                        <td>
                            <input type="checkbox" class="selectDebtor" value="{{ $person->id }}">
                        </td>
                        <td class="person-name">{{ $person->full_name }}</td>
                        <td>{{ $person->mobile }}</td>
                        <td>{{ $person->accounting_code }}</td>
                        <td>{{ $person->type_label }}</td>
                        <td class="debt-col text-danger fw-bold">{{ number_format($person->balance) }}</td>
                        <td>{{ number_format($person->total_purchases) }}</td>
                        <td>{{ number_format($person->total_sales) }}</td>
                        <td>{{ $person->status=='active' ? 'فعال' : 'غیرفعال' }}</td>
                    </tr>
                    @endforeach
                </tbody>
            </table>
            <div class="mt-3">
                {{ $debtors->withQueryString()->links() }}
            </div>
        </div>
    </div>
</div>
@endsection

@push('scripts')
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/datatables.net@2.0.8/js/dataTables.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/datatables.net-bs5@2.0.8/js/dataTables.bootstrap5.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/moment@2.29.4/min/moment.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/moment-jalaali@0.9.2/build/moment-jalaali.js"></script>
<script src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<script>
$(function() {
    // DataTable
    $('#debtorsTable').DataTable({
        paging: false,
        searching: false,
        info: false,
        ordering: true,
        language: {
            emptyTable: "هیچ بدهکاری یافت نشد"
        }
    });

    // Date range picker
    $('.daterange').daterangepicker({
        locale: {
            format: 'jYYYY/jMM/jDD',
            separator: ' - ',
            applyLabel: 'اعمال',
            cancelLabel: 'انصراف',
            fromLabel: 'از',
            toLabel: 'تا',
            weekLabel: 'هفته',
            daysOfWeek: ['ی', 'د', 'س', 'چ', 'پ', 'ج', 'ش'],
            monthNames: [
                'فروردین', 'اردیبهشت', 'خرداد', 'تیر', 'مرداد', 'شهریور',
                'مهر', 'آبان', 'آذر', 'دی', 'بهمن', 'اسفند'
            ],
            firstDay: 6
        },
        opens: 'right',
        autoUpdateInput: false
    }).on('apply.daterangepicker', function(ev, picker) {
        $(this).val(picker.startDate.format('jYYYY/jMM/jDD') + ' - ' + picker.endDate.format('jYYYY/jMM/jDD'));
    }).on('cancel.daterangepicker', function(ev, picker) {
        $(this).val('');
    });

    // Pie chart مجموع کل بدهی
    var totalDebt = {{ $totalDebt }};
    var totalDebtPie = new Chart(document.getElementById('totalDebtPie'), {
        type: 'doughnut',
        data: {
            labels: ['مجموع بدهی', 'سایر'],
            datasets: [{
                data: [totalDebt, 0],
                backgroundColor: ['#dc3545', '#f8f9fa'],
                borderWidth: 1
            }]
        },
        options: {
            plugins: { legend: { display: false } },
            cutout: '70%'
        }
    });

    // Pie chart بدهی انتخاب شده
    var selectedDebtPie = new Chart(document.getElementById('selectedDebtPie'), {
        type: 'doughnut',
        data: {
            labels: ['بدهی انتخابی', 'باقی‌مانده'],
            datasets: [{
                data: [0, totalDebt],
                backgroundColor: ['#0d6efd', '#f8f9fa'],
                borderWidth: 1
            }]
        },
        options: {
            plugins: { legend: { display: false } },
            cutout: '70%'
        }
    });

    // انتخاب همه
    $('#selectAllDebtors').on('change', function() {
        $('.selectDebtor').prop('checked', this.checked).trigger('change');
    });

    // وقتی تیک شخصی خورد یا برداشته شد
    $(document).on('change', '.selectDebtor', function() {
        let ids = $('.selectDebtor:checked').map(function(){ return $(this).val(); }).get();
        $('#selectedCount').text(ids.length);

        // جمع بدهی انتخاب شده و بروزرسانی نمودار
        $.get('{{ route("persons.debtors.ajax") }}', {ids: ids}, function(data) {
            $('#selectedDebtAmount').text(data.total.toLocaleString('fa-IR') + ' تومان');
            selectedDebtPie.data.datasets[0].data = [data.total, totalDebt-data.total];
            selectedDebtPie.update();
        });

        // اگر یک نفر انتخاب شد اطلاعاتش را نشان بده
        if(ids.length === 1) {
            let row = $('tr[data-id="'+ids[0]+'"]');
            let name = row.find('.person-name').text();
            let mobile = row.find('td').eq(2).text();
            let code = row.find('td').eq(3).text();
            let type = row.find('td').eq(4).text();
            let debt = row.find('.debt-col').text();
            let paid = row.find('td').eq(6).text();
            let sales = row.find('td').eq(7).text();
            let status = row.find('td').eq(8).text();
            $('#personDetailCard').html(`
                <div class="mb-2"><b>${name}</b></div>
                <div>کد: ${code}</div>
                <div>موبایل: ${mobile}</div>
                <div>نوع: ${type}</div>
                <div>بدهی: <span class="text-danger fw-bold">${debt}</span></div>
                <div>پرداخت شده: ${paid}</div>
                <div>فروش: ${sales}</div>
                <div>وضعیت: ${status}</div>
                <a href="/persons/${ids[0]}" class="btn btn-sm btn-outline-primary mt-2">مشاهده جزئیات</a>
            `);
        } else {
            $('#personDetailCard').html('<div class="text-muted">برای مشاهده اطلاعات، یک شخص را انتخاب کنید</div>');
        }
    });
});
</script>
@endpush
