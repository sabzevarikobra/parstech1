@extends('layouts.app')
@section('title', 'لیست خدمات')

@section('head')
<link rel="stylesheet" href="{{ asset('css/service-index.css') }}">
<style>
    body {
        background: linear-gradient(120deg, #e0e7ff 0%, #f1f7fa 100%) fixed;
    }
    .card.service-card {
        border-radius: 24px;
        box-shadow: 0 10px 40px #2563eb22;
        border: none;
        background: #fff;
        overflow: hidden;
    }
    .card-header.service-header {
        background: linear-gradient(90deg, #2563eb 0%, #3b82f6 100%);
        color: #fff;
        border-radius: 24px 24px 0 0;

        font-weight: 900;

        display: flex;
        justify-content: space-between;
        align-items: center;

    }
    .card-header.service-header h5 {
        margin-bottom: 0;
        font-size: 2rem;
        font-weight: 900;
        letter-spacing: .04em;
        color: #fff;
    }
    .service-list-table th,
    .service-list-table td {
        vertical-align: middle !important;
        font-size: 1.07em;
        text-align: center;
    }
    .service-list-table th {
        background: linear-gradient(90deg, #ecf2ff 0%, #e0e7ff 100%);
        color: #23408c;
        font-weight: 900;
        border-top: 0;
    }
    .service-list-table tr {
        background: #fff !important;
    }
    .service-list-table tr:hover {
        background: #f1f7fa !important;
        transition: background 0.18s;
    }
    .btn-action {
        border-radius: 11px;
        font-size: 1.03em;
        font-weight: 700;
        padding: 7px 18px;
        margin: 0 2px;
        transition: background 0.2s, color 0.18s;
    }
    .btn-gradient {
        background: linear-gradient(90deg, #2563eb 10%, #3b82f6 100%);
        color: #fff !important;
        border: none;
        border-radius: 14px;
        padding: 10px 36px;
        font-weight: 900;
        font-size: 1.13em;
        box-shadow: 0 2px 14px #2563eb22;
        transition: background 0.2s, box-shadow 0.2s;
        letter-spacing: 0.03em;
        margin-top: 0;
    }
    .btn-gradient:hover {
        background: linear-gradient(90deg, #1e2549 0%, #2563eb 90%);
        box-shadow: 0 7px 24px #2563eb33;
    }
    .badge-status {
        padding: 7px 16px;
        font-size: 1em;
        border-radius: 10px;
        font-weight: 900;
        letter-spacing: 0.01em;
        border: 1.5px solid #22c55e;
        background: linear-gradient(90deg, #25d366 40%, #a3e635 100%);
        color: #134e4a;
    }
    .badge-status.inactive {
        background: linear-gradient(90deg, #fca5a5 40%, #f43f5e 100%);
        color: #fff;
        border: 1.5px solid #f87171;
    }
    .search-bar {
        max-width: 320px;
        margin-left: auto;
    }
    .search-bar input {
        border-radius: 20px;
        font-size: 1.04em;
        background: #f8fafc;
        border: 1.5px solid #e0e7ff;
        padding: 8px 18px;
        font-weight: 600;
    }
    .custom-pagination .page-link {
        border-radius: 7px !important;
        color: #23408c;
        font-weight: 700;
    }
    .custom-pagination .active .page-link {
        background: linear-gradient(90deg, #2563eb 0%, #3b82f6 100%);
        color: #fff !important;
        font-weight: 900;
        border: none;
    }
    .service-image-thumb {
        width: 50px;
        height: 50px;
        border-radius: 13px;
        object-fit: cover;
        background: #f1f5f9;
        box-shadow: 0 2px 8px #b8bfea33;
        border: 1px solid #e0e7ff;
    }
    .table-responsive {
        border-radius: 18px;
        overflow: hidden;
    }
    .no-services-row td {
        color: #6b7280 !important;
        font-size: 1.13em;
        font-weight: 600;
        padding: 40px 0;
        text-align: center;
        background: #f0f6ff !important;
    }
    @media (max-width: 900px) {
        .card.service-card { padding: 0.7rem; }
        .card-header.service-header { padding: 1.2rem 0.7rem; font-size: 1.08rem; }
        .btn-gradient { width: 100%; font-size: 1em; }
    }
    @media (max-width: 700px) {
        .card-header.service-header h5 { font-size: 1.1rem; }
        .service-list-table th, .service-list-table td { font-size: .93em; }
    }
</style>
@endsection

@section('content')
<section class="content pt-4">
    <div class="container-fluid">
        <div class="card service-card shadow">
            <div class="card-header service-header">
                <div>
                    <i class="fa fa-list-alt fa-lg ms-1"></i>
                    <h5 class="d-inline">لیست خدمات</h5>
                </div>
                <div class="d-flex align-items-center gap-2">
                    <form method="GET" action="{{ route('services.index') }}" class="search-bar d-inline-block">
                        <input type="text" name="q" class="form-control" placeholder="جستجو (نام، کد، دسته‌بندی...)" value="{{ request('q') }}">
                    </form>
                    <a href="{{ route('services.create') }}" class="btn btn-gradient btn-action">
                        <i class="fa fa-plus-circle me-1"></i>افزودن خدمات جدید
                    </a>
                </div>
            </div>

            @if(session('success'))
                <div class="alert alert-success animate__animated animate__fadeInDown">{{ session('success') }}</div>
            @endif

            <div class="card-body">
                <div class="table-responsive mb-2">
                    <table class="table service-list-table align-middle table-striped">
                        <thead>
                            <tr>
                                <th>ردیف</th>
                                <th>تصویر</th>
                                <th>نام خدمات</th>
                                <th>کد خدمات</th>
                                <th>دسته‌بندی</th>
                                <th>واحد</th>
                                <th>قیمت (تومان)</th>
                                <th>وضعیت</th>
                                <th>عملیات</th>
                            </tr>
                        </thead>
                        <tbody id="services-list">
                            @forelse($services as $service)
                                <tr>
                                    <td>{{ ($services->currentPage()-1)*$services->perPage() + $loop->iteration }}</td>
                                    <td>
                                        @if($service->image)
                                            <img src="{{ asset('storage/'.$service->image) }}" class="service-image-thumb" alt="تصویر">
                                        @else
                                            <img src="{{ asset('img/no-image-service.svg') }}" class="service-image-thumb" alt="بدون تصویر">
                                        @endif
                                    </td>
                                    <td>
                                        <span class="fw-bold">{{ $service->title }}</span>
                                        <div class="small text-muted">{{ Str::limit($service->short_description, 32) }}</div>
                                    </td>
                                    <td>
                                        <span class="badge bg-light text-dark border">{{ $service->service_code }}</span>
                                    </td>
                                    <td>
                                        @php
                                            $cat = $serviceCategories->firstWhere('id', $service->service_category_id);
                                        @endphp
                                        <span class="badge bg-info text-white">{{ $cat ? $cat->name : '-' }}</span>
                                    </td>
                                    <td>
                                        <span class="badge bg-primary-subtle text-primary">{{ $service->unit }}</span>
                                    </td>
                                    <td>
                                        <span class="fw-bold text-success">{{ number_format($service->price) }}</span>
                                    </td>
                                    <td>
                                        @if($service->is_active)
                                            <span class="badge-status">فعال</span>
                                        @else
                                            <span class="badge-status inactive">غیرفعال</span>
                                        @endif
                                    </td>
                                    <td>
                                        <a href="{{ route('services.edit', $service->id) }}" title="ویرایش" class="btn btn-sm btn-outline-info btn-action"><i class="fa fa-edit"></i></a>
                                        <a href="{{ route('services.show', $service->id) }}" title="نمایش" class="btn btn-sm btn-outline-secondary btn-action"><i class="fa fa-eye"></i></a>
                                        <form action="{{ route('services.destroy', $service->id) }}" method="POST" class="d-inline-block" onsubmit="return confirm('آیا از حذف این خدمت مطمئن هستید؟')">
                                            @csrf
                                            @method('DELETE')
                                            <button type="submit" class="btn btn-sm btn-outline-danger btn-action" title="حذف"><i class="fa fa-trash"></i></button>
                                        </form>
                                    </td>
                                </tr>
                            @empty
                                <tr class="no-services-row">
                                    <td colspan="9">هیچ خدمتی ثبت نشده است.</td>
                                </tr>
                            @endforelse
                        </tbody>
                    </table>
                </div>
                <nav>
                    {!! $services->appends(request()->all())->links('pagination::bootstrap-5', ['class' => 'custom-pagination']) !!}
                </nav>
            </div>
        </div>
    </div>
</section>
@endsection

@section('scripts')
<script>
document.addEventListener('DOMContentLoaded', function(){
    // جستجو با اینتر
    document.querySelector('.search-bar input').addEventListener('keydown', function(e){
        if(e.key === "Enter") this.form.submit();
    });

    // نمایش پیام زیبای حذف (در صورت نیاز، SweetAlert)
    document.querySelectorAll('form[action*="services"][method="POST"]').forEach(form => {
        form.addEventListener('submit', function(e){
            if(!confirm('آیا از حذف این خدمت مطمئن هستید؟')) e.preventDefault();
        });
    });
});
</script>
@endsection
