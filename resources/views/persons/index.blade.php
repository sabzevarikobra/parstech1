@extends('layouts.app')

@section('title', 'لیست اشخاص')

@push('styles')
<style>
.person-card {
    transition: all 0.3s ease;
    border: none;
    box-shadow: 0 2px 15px rgba(0,0,0,0.05);
}

.person-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 5px 20px rgba(0,0,0,0.1);
}

.stats-item {
    padding: 10px;
    border-radius: 8px;
    background: linear-gradient(45deg, #f8f9fa, #ffffff);
    border: 1px solid #e9ecef;
}

.person-type-customer { border-right: 4px solid #4e73df; }
.person-type-supplier { border-right: 4px solid #1cc88a; }
.person-type-employee { border-right: 4px solid #f6c23e; }
.person-type-shareholder { border-right: 4px solid #e74a3b; }

.financial-badge {
    font-size: 0.85rem;
    padding: 5px 10px;
    border-radius: 15px;
}

.financial-badge.positive {
    background-color: #e3fcef;
    color: #1cc88a;
}

.financial-badge.negative {
    background-color: #fce3e3;
    color: #e74a3b;
}

.search-box {
    background: #f8f9fc;
    padding: 20px;
    border-radius: 10px;
    margin-bottom: 20px;
}

.table-responsive {
    border-radius: 10px;
    box-shadow: 0 2px 15px rgba(0,0,0,0.05);
}
</style>
@endpush

@section('content')
<div class="container-fluid">
    <!-- Header & Stats -->
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800">لیست اشخاص</h1>
        <a href="{{ route('persons.create') }}" class="btn btn-primary">
            <i class="fas fa-plus me-2"></i>افزودن شخص جدید
        </a>
    </div>

    <!-- Quick Stats -->
    <div class="row mb-4">
        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-primary h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                کل اشخاص</div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800">{{ $totalPersons }}</div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-users fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-success h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                مجموع معاملات</div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800">
                                {{ number_format($totalTransactions) }} ریال
                            </div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-dollar-sign fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-info h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-info text-uppercase mb-1">
                                مشتریان فعال</div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800">{{ $activeCustomers }}</div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-user-check fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-xl-3 col-md-6 mb-4">
            <div class="card border-left-warning h-100 py-2">
                <div class="card-body">
                    <div class="row no-gutters align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                بدهکاران</div>
                            <div class="h5 mb-0 font-weight-bold text-gray-800">{{ $debtorsCount }}</div>
                        </div>
                        <div class="col-auto">
                            <i class="fas fa-exclamation-triangle fa-2x text-gray-300"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Search Box -->
    <div class="search-box">
        <form action="{{ route('persons.index') }}" method="GET">
            <div class="row g-3">
                <div class="col-md-3">
                    <input type="text" name="search" class="form-control"
                           placeholder="جستجو..." value="{{ request('search') }}">
                </div>
                <div class="col-md-2">
                    <select name="type" class="form-select">
                        <option value="">همه انواع</option>
                        <option value="customer" {{ request('type') == 'customer' ? 'selected' : '' }}>مشتری</option>
                        <option value="supplier" {{ request('type') == 'supplier' ? 'selected' : '' }}>تامین کننده</option>
                        <option value="employee" {{ request('type') == 'employee' ? 'selected' : '' }}>کارمند</option>
                        <option value="shareholder" {{ request('type') == 'shareholder' ? 'selected' : '' }}>سهامدار</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <select name="status" class="form-select">
                        <option value="">همه وضعیت‌ها</option>
                        <option value="active" {{ request('status') == 'active' ? 'selected' : '' }}>فعال</option>
                        <option value="inactive" {{ request('status') == 'inactive' ? 'selected' : '' }}>غیرفعال</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <div class="input-group">
                        <input type="text" name="date_range" class="form-control daterange"
                               placeholder="بازه زمانی" value="{{ request('date_range') }}">
                        <span class="input-group-text"><i class="fas fa-calendar"></i></span>
                    </div>
                </div>
                <div class="col-md-2">
                    <button type="submit" class="btn btn-primary w-100">
                        <i class="fas fa-search me-2"></i>جستجو
                    </button>
                </div>
            </div>
        </form>
    </div>

    <!-- Persons List -->
    <div class="table-responsive">
        <table class="table table-hover">
            <thead class="bg-light">
                <tr>
                    <th>کد</th>
                    <th>نام و نام خانوادگی</th>
                    <th>نوع</th>
                    <th>موبایل</th>
                    <th>مجموع خرید</th>
                    <th>مجموع فروش</th>
                    <th>مانده حساب</th>
                    <th>آخرین تراکنش</th>
                    <th>عملیات</th>
                </tr>
            </thead>
            <tbody>
                @forelse($persons as $person)
                    <tr class="person-type-{{ $person->type }}">
                        <td>{{ $person->accounting_code }}</td>
                        <td>
                            <div class="d-flex align-items-center">
                                <div class="avatar-initial rounded-circle me-2
                                    bg-{{ $person->type == 'customer' ? 'primary' :
                                         ($person->type == 'supplier' ? 'success' :
                                         ($person->type == 'employee' ? 'warning' : 'danger')) }}">
                                    {{ substr($person->first_name, 0, 1) }}
                                </div>
                                <div>
                                    <div class="fw-bold">{{ $person->full_name }}</div>
                                    <small class="text-muted">{{ $person->company_name }}</small>
                                </div>
                            </div>
                        </td>
                        <td>
                            <span class="badge bg-{{ $person->type == 'customer' ? 'primary' :
                                                   ($person->type == 'supplier' ? 'success' :
                                                   ($person->type == 'employee' ? 'warning' : 'danger')) }}">
                                {{ __('types.' . $person->type) }}
                            </span>
                        </td>
                        <td>{{ $person->mobile }}</td>
                        <td>{{ number_format($person->total_purchases) }} ریال</td>
                        <td>{{ number_format($person->total_sales) }} ریال</td>
                        <td>
                            <span class="financial-badge {{ $person->balance >= 0 ? 'positive' : 'negative' }}">
                                {{ number_format(abs($person->balance)) }} ریال
                                {{ $person->balance >= 0 ? 'بستانکار' : 'بدهکار' }}
                            </span>
                        </td>
                        <td>{{ $person->last_transaction_date ? jdate($person->last_transaction_date)->ago() : '-' }}</td>
                        <td>
                            <div class="btn-group">
                                <a href="{{ route('persons.show', $person) }}"
                                   class="btn btn-sm btn-outline-primary">
                                    <i class="fas fa-eye"></i>
                                </a>
                                <a href="{{ route('persons.edit', $person) }}"
                                   class="btn btn-sm btn-outline-warning">
                                    <i class="fas fa-edit"></i>
                                </a>
                                <button type="button"
                                        class="btn btn-sm btn-outline-danger delete-person"
                                        data-id="{{ $person->id }}">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </div>
                        </td>
                    </tr>
                @empty
                    <tr>
                        <td colspan="9" class="text-center py-4">
                            <div class="d-flex flex-column align-items-center">
                                <i class="fas fa-users fa-3x text-muted mb-2"></i>
                                <p class="text-muted">هیچ شخصی یافت نشد</p>
                            </div>
                        </td>
                    </tr>
                @endforelse
            </tbody>
        </table>
    </div>

    <!-- Pagination -->
    <div class="d-flex justify-content-center mt-4">
        {{ $persons->withQueryString()->links() }}
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">تایید حذف</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                آیا از حذف این شخص اطمینان دارید؟
            </div>
            <div class="modal-footer">
                <form id="deleteForm" action="" method="POST">
                    @csrf
                    @method('DELETE')
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">انصراف</button>
                    <button type="submit" class="btn btn-danger">حذف</button>
                </form>
            </div>
        </div>
    </div>
</div>
@endsection

@push('scripts')
<script>
$(document).ready(function() {
    // Date Range Picker
    $('.daterange').daterangepicker({
        locale: {
            format: 'YYYY/MM/DD',
            separator: ' - ',
            applyLabel: 'اعمال',
            cancelLabel: 'انصراف'
        }
    });

    // Delete Confirmation
    $('.delete-person').click(function() {
        const id = $(this).data('id');
        $('#deleteForm').attr('action', `/persons/${id}`);
        $('#deleteModal').modal('show');
    });
});
</script>
@endpush
