@extends('layouts.app')

@section('title', 'لیست بدهکاران')

@push('styles')
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/chart.js/dist/chart.min.css">
@endpush

@section('content')
<div class="container-fluid py-4">
    <div class="row mb-4">
        <div class="col-lg-8">
            <div class="card shadow p-4">
                <h2 class="mb-4">لیست بدهکاران</h2>
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead>
                            <tr>
                                <th>نام</th>
                                <th>موبایل</th>
                                <th>جمع بدهی (تومان)</th>
                                <th>مجموع پرداختی</th>
                                <th>مجموع خرید</th>
                                <th>مانده حساب</th>
                                <th>عملیات</th>
                            </tr>
                        </thead>
                        <tbody>
                        @forelse($debtors as $person)
                            <tr>
                                <td>{{ $person->full_name }}</td>
                                <td>{{ $person->mobile }}</td>
                                <td class="text-danger fw-bold">{{ number_format(abs($person->balance)) }}</td>
                                <td>{{ number_format($person->total_purchases) }}</td>
                                <td>{{ number_format($person->total_sales) }}</td>
                                <td class="text-danger fw-bold">{{ number_format($person->balance) }}</td>
                                <td>
                                    <a href="{{ route('persons.show', $person) }}" class="btn btn-sm btn-outline-primary">
                                        جزئیات
                                    </a>
                                </td>
                            </tr>
                        @empty
                            <tr><td colspan="7" class="text-center">هیچ بدهکاری یافت نشد</td></tr>
                        @endforelse
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="col-lg-4">
            <div class="card shadow p-4">
                <h6 class="mb-3">نمودار بدهکاران</h6>
                <canvas id="debtorsChart"></canvas>
            </div>
        </div>
    </div>
</div>
@endsection

@push('scripts')
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
document.addEventListener('DOMContentLoaded', function () {
    var ctx = document.getElementById('debtorsChart').getContext('2d');
    var chart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: {!! json_encode($chartData['labels']) !!},
            datasets: [{
                label: 'مبلغ بدهی (تومان)',
                data: {!! json_encode($chartData['amounts']) !!},
                backgroundColor: 'rgba(220,53,69,0.5)',
                borderColor: 'rgba(220,53,69,1)',
                borderWidth: 1
            }]
        },
        options: {
            indexAxis: 'y',
            responsive: true,
            plugins: {
                legend: { display: false },
                tooltip: { rtl: true }
            },
            scales: {
                x: {
                    beginAtZero: true,
                    ticks: {
                        callback: function(value) {
                            return new Intl.NumberFormat('fa-IR').format(value);
                        }
                    }
                }
            }
        }
    });
});
</script>
@endpush
