@extends('layouts.app')

@section('title', 'ایجاد شخص جدید')

@push('styles')
<link rel="stylesheet" href="https://unpkg.com/persian-datepicker@latest/dist/css/persian-datepicker.min.css">
<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
<style>
.preview-card {
    position: sticky;
    top: 20px;
    background: #fff;
    border-radius: 15px;
    box-shadow: 0 0 20px rgba(0,0,0,0.05);
    padding: 20px;
    margin-bottom: 20px;
    transition: all 0.3s ease;
}

.preview-card:hover {
    box-shadow: 0 0 30px rgba(0,0,0,0.1);
}

.preview-avatar {
    width: 80px;
    height: 80px;
    background: #4e73df;
    color: white;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 2rem;
    margin-bottom: 15px;
}

.nav-tabs {
    border-bottom: 2px solid #e3e6f0;
    margin-bottom: 25px;
}

.nav-tabs .nav-link {
    border: none;
    color: #858796;
    padding: 12px 20px;
    font-weight: 500;
    transition: all 0.3s ease;
}

.nav-tabs .nav-link.active {
    color: #4e73df;
    border-bottom: 3px solid #4e73df;
    background: transparent;
}

.tab-content {
    background: #fff;
    border-radius: 15px;
    padding: 25px;
    box-shadow: 0 0 20px rgba(0,0,0,0.05);
}

.form-label {
    font-weight: 500;
    margin-bottom: 8px;
}

.form-control {
    border-radius: 10px;
    padding: 10px 15px;
}

.form-control:focus {
    box-shadow: 0 0 0 0.2rem rgba(78,115,223,0.15);
    border-color: #4e73df;
}

.bank-account-row {
    background: #f8f9fc;
    border-radius: 10px;
    padding: 15px;
    margin-bottom: 15px;
    transition: all 0.3s ease;
}

.bank-account-row:hover {
    background: #eaecf4;
}

.required-field::after {
    content: '*';
    color: #e74a3b;
    margin-right: 4px;
}

.actions-bar {
    position: sticky;
    bottom: 0;
    background: white;
    padding: 15px;
    border-top: 1px solid #e3e6f0;
    text-align: left;
    box-shadow: 0 -5px 20px rgba(0,0,0,0.05);
}
</style>
@endpush

@section('content')
<div class="container-fluid py-4">
    <div class="row">
        <!-- Preview Card -->
        <div class="col-lg-3">
            <div class="preview-card" id="previewCard">
                <div class="preview-avatar" id="previewAvatar">?</div>
                <div class="preview-info">
                    <h5 class="mb-3" id="previewName">نام و نام خانوادگی</h5>
                    <p class="mb-2" id="previewCode">کد: -</p>
                    <p class="mb-2" id="previewType">نوع: -</p>
                    <p class="mb-2" id="previewMobile">موبایل: -</p>
                    <p class="mb-0" id="previewCompany">شرکت: -</p>
                </div>
            </div>
        </div>

        <!-- Main Form -->
        <div class="col-lg-9">
            <form id="personForm" action="{{ route('persons.store') }}" method="POST">
                @csrf

                <ul class="nav nav-tabs" role="tablist">
                    <li class="nav-item">
                        <a class="nav-link active" data-bs-toggle="tab" href="#main">
                            <i class="fas fa-user me-2"></i>اطلاعات اصلی
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-bs-toggle="tab" href="#contact">
                            <i class="fas fa-phone me-2"></i>اطلاعات تماس
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-bs-toggle="tab" href="#address">
                            <i class="fas fa-map-marker-alt me-2"></i>آدرس
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-bs-toggle="tab" href="#bank">
                            <i class="fas fa-university me-2"></i>اطلاعات بانکی
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-bs-toggle="tab" href="#extra">
                            <i class="fas fa-info-circle me-2"></i>اطلاعات تکمیلی
                        </a>
                    </li>
                </ul>

                <div class="tab-content">
                    <!-- Tab 1: Main Info -->
                    <div class="tab-pane fade show active" id="main">
                        @include('persons.partials.main-info')
                    </div>

                    <!-- Tab 2: Contact -->
                    <div class="tab-pane fade" id="contact">
                        @include('persons.partials.contact-info')
                    </div>

                    <!-- Tab 3: Address -->
                    <div class="tab-pane fade" id="address">
                        @include('persons.partials.address-info')
                    </div>

                    <!-- Tab 4: Bank -->
                    <div class="tab-pane fade" id="bank">
                        @include('persons.partials.bank-info')
                    </div>

                    <!-- Tab 5: Extra -->
                    <div class="tab-pane fade" id="extra">
                        @include('persons.partials.extra-info')
                    </div>
                </div>

                <!-- Actions Bar -->
                <div class="actions-bar">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save me-2"></i>ذخیره
                    </button>
                    <a href="{{ route('persons.index') }}" class="btn btn-secondary ms-2">
                        <i class="fas fa-times me-2"></i>انصراف
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>
@endsection

@push('scripts')
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://unpkg.com/persian-date@latest/dist/persian-date.min.js"></script>
<script src="https://unpkg.com/persian-datepicker@latest/dist/js/persian-datepicker.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

<script>
$(document).ready(function() {
    // Live Preview Update
    function updatePreview() {
        const firstName = $('input[name="first_name"]').val();
        const lastName = $('input[name="last_name"]').val();
        const fullName = `${firstName} ${lastName}`.trim();

        $('#previewName').text(fullName || 'نام و نام خانوادگی');
        $('#previewAvatar').text(fullName ? fullName[0].toUpperCase() : '?');
        $('#previewCode').text(`کد: ${$('input[name="accounting_code"]').val() || '-'}`);
        $('#previewType').text(`نوع: ${$('select[name="type"] option:selected').text() || '-'}`);
        $('#previewMobile').text(`موبایل: ${$('input[name="mobile"]').val() || '-'}`);
        $('#previewCompany').text(`شرکت: ${$('input[name="company_name"]').val() || '-'}`);
    }

    // Update preview on input change
    $('#personForm').on('input change', 'input, select', updatePreview);

    // Initialize Preview
    updatePreview();

    // Select2 Initialization
    $('.select2').select2({
        theme: 'bootstrap4',
        width: '100%'
    });

    // Persian Datepicker
    $('.datepicker').persianDatepicker({
        format: 'YYYY/MM/DD',
        initialValue: false,
        autoClose: true
    });

    // Dynamic Bank Accounts
    let bankIndex = 0;
    $('#addBankAccount').click(function() {
        const template = $('#bankAccountTemplate').html();
        const newRow = template.replace(/INDEX/g, bankIndex++);
        $('#bankAccountsContainer').append(newRow);
    });

    $(document).on('click', '.removeBankAccount', function() {
        $(this).closest('.bank-account-row').fadeOut(300, function() {
            $(this).remove();
        });
    });

    // Form Validation
    $('#personForm').on('submit', function(e) {
        let isValid = true;
        $(this).find('[required]').each(function() {
            if (!$(this).val()) {
                isValid = false;
                $(this).addClass('is-invalid');
                // Switch to tab containing error
                const tabId = $(this).closest('.tab-pane').attr('id');
                $(`a[href="#${tabId}"]`).tab('show');
                return false; // break each loop
            }
        });

        if (!isValid) {
            e.preventDefault();
            alert('لطفاً همه فیلدهای الزامی را پر کنید.');
        }
    });

        // تنظیمات استان و شهر
        $('#province_select').on('change', function() {
        const provinceId = $(this).val();
        const citySelect = $('#city_select');

        // پاک کردن شهرهای قبلی
        citySelect.empty().prop('disabled', true);

        if (provinceId) {
            // نمایش loading
            citySelect.html('<option value="">در حال دریافت شهرها...</option>');

            // درخواست Ajax
            $.ajax({
                url: `/persons/province/${provinceId}/cities`,
                method: 'GET',
                success: function(response) {
                    citySelect.empty().prop('disabled', false);
                    citySelect.append('<option value="">انتخاب شهر</option>');

                    // اضافه کردن شهرها
                    response.forEach(function(city) {
                        citySelect.append(`<option value="${city.id}">${city.text}</option>`);
                    });

                    // اگر مقدار قبلی وجود داشت
                    @if(old('city'))
                        citySelect.val('{{ old("city") }}');
                    @endif
                },
                error: function() {
                    citySelect.html('<option value="">خطا در دریافت شهرها</option>');
                    console.error('خطا در دریافت لیست شهرها');
                }
            });
        } else {
            citySelect.html('<option value="">ابتدا استان را انتخاب کنید</option>');
        }
    });

    // اگر از قبل استانی انتخاب شده بود (مثلا در حالت edit یا old input)
    @if(old('province'))
        $('#province_select').trigger('change');
    @endif

    function getNextCode() {
        $.ajax({
            url: '/api/persons/next-code',
            method: 'GET',
            success: function(response) {
                console.log('Response:', response); // برای دیباگ
                if (response.code) {
                    $('#accounting_code').val(response.code);
                    updatePreview(); // به‌روزرسانی پیش‌نمایش
                }
            },
            error: function(xhr, status, error) {
                console.error('Error fetching next code:', error);
                $('#accounting_code').val('person-10001');
            }
        });
    }

    // مقداردهی اولیه اگر حالت خودکار است
    const $accountingCodeInput = $('#accounting_code');
    const $autoSwitch = $('#autoCodeSwitch');

    if ($autoSwitch.is(':checked')) {
        $accountingCodeInput.prop('readonly', true);
        getNextCode();
    }

    // رویداد تغییر سوییچ
    $autoSwitch.change(function() {
        if ($(this).is(':checked')) {
            $accountingCodeInput.prop('readonly', true);
            getNextCode();
        } else {
            $accountingCodeInput.prop('readonly', false);
            $accountingCodeInput.val('').focus();
        }
        updatePreview();
    });
});
</script>
@endpush
