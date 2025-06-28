@extends('layouts.app')

@section('title', 'ویرایش ' . $person->full_name)

@push('styles')
<link rel="stylesheet" href="{{ asset('css/persian-datepicker.min.css') }}">
<style>
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
</style>
@endpush

@section('content')
<div class="container-fluid">
    <h1 class="h3 mb-4 text-gray-800">ویرایش اطلاعات {{ $person->full_name }}</h1>

    <form action="{{ route('persons.update', $person) }}" method="POST" id="editPersonForm">
        @csrf
        @method('PUT')

        <div class="row">
            <div class="col-md-8">
                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">اطلاعات اصلی</h6>
                    </div>
                    <div class="card-body">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label">نام</label>
                                <input type="text" name="first_name" class="form-control" value="{{ old('first_name', $person->first_name) }}">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">نام خانوادگی</label>
                                <input type="text" name="last_name" class="form-control" value="{{ old('last_name', $person->last_name) }}">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">نام شرکت</label>
                                <input type="text" name="company_name" class="form-control" value="{{ old('company_name', $person->company_name) }}">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">نوع</label>
                                <select name="type" class="form-select" required>
                                    <option value="customer" {{ old('type', $person->type) == 'customer' ? 'selected' : '' }}>مشتری</option>
                                    <option value="supplier" {{ old('type', $person->type) == 'supplier' ? 'selected' : '' }}>تامین کننده</option>
                                    <option value="shareholder" {{ old('type', $person->type) == 'shareholder' ? 'selected' : '' }}>سهامدار</option>
                                    <option value="employee" {{ old('type', $person->type) == 'employee' ? 'selected' : '' }}>کارمند</option>
                                </select>
                            </div>
                            <!-- سایر فیلدهای اصلی -->
                        </div>
                    </div>
                </div>

                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">اطلاعات تماس</h6>
                    </div>
                    <div class="card-body">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label">موبایل</label>
                                <input type="text" name="mobile" class="form-control" value="{{ old('mobile', $person->mobile) }}">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">تلفن</label>
                                <input type="text" name="phone" class="form-control" value="{{ old('phone', $person->phone) }}">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">ایمیل</label>
                                <input type="email" name="email" class="form-control" value="{{ old('email', $person->email) }}">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">وب‌سایت</label>
                                <input type="text" name="website" class="form-control" value="{{ old('website', $person->website) }}">
                            </div>
                        </div>
                    </div>
                </div>

                <!-- بخش آدرس -->
                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">آدرس</h6>
                    </div>
                    <div class="card-body">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label">استان</label>
                                <select name="province" id="province_select" class="form-select" required>
                                    <option value="">انتخاب استان</option>
                                    @foreach($provinces as $province)
                                        <option value="{{ $province->id }}" {{ old('province', $person->province) == $province->id ? 'selected' : '' }}>
                                            {{ $province->name }}
                                        </option>
                                    @endforeach
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">شهر</label>
                                <select name="city" id="city_select" class="form-select" required>
                                    <option value="">ابتدا استان را انتخاب کنید</option>
                                </select>
                            </div>
                            <div class="col-12">
                                <label class="form-label">آدرس کامل</label>
                                <textarea name="address" class="form-control" rows="3">{{ old('address', $person->address) }}</textarea>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">کد پستی</label>
                                <input type="text" name="postal_code" class="form-control" value="{{ old('postal_code', $person->postal_code) }}">
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <!-- حساب‌های بانکی -->
                <div class="card shadow mb-4">
                    <div class="card-header py-3 d-flex justify-content-between align-items-center">
                        <h6 class="m-0 font-weight-bold text-primary">حساب‌های بانکی</h6>
                        <button type="button" class="btn btn-sm btn-success" id="add-bank-account">
                            <i class="fas fa-plus"></i>
                        </button>
                    </div>
                    <div class="card-body">
                        <div id="bank-accounts">
                            @foreach($person->bankAccounts as $account)
                            <div class="bank-account-row">
                                <div class="mb-2">
                                    <label class="form-label">نام بانک</label>
                                    <input type="text" name="bank_accounts[bank_name][]" class="form-control" value="{{ $account->bank_name }}">
                                </div>
                                <div class="mb-2">
                                    <label class="form-label">شماره حساب</label>
                                    <input type="text" name="bank_accounts[account_number][]" class="form-control" value="{{ $account->account_number }}">
                                </div>
                                <div class="mb-2">
                                    <label class="form-label">شماره کارت</label>
                                    <input type="text" name="bank_accounts[card_number][]" class="form-control" value="{{ $account->card_number }}">
                                </div>
                                <div class="mb-2">
                                    <label class="form-label">شماره شبا</label>
                                    <input type="text" name="bank_accounts[iban][]" class="form-control" value="{{ $account->iban }}">
                                </div>
                                <button type="button" class="btn btn-sm btn-danger remove-bank-account">
                                    <i class="fas fa-times"></i>
                                </button>
                            </div>
                            @endforeach
                        </div>
                    </div>
                </div>

                <!-- اطلاعات تکمیلی -->
                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">اطلاعات تکمیلی</h6>
                    </div>
                    <div class="card-body">
                        <div class="mb-3">
                            <label class="form-label">توضیحات</label>
                            <textarea name="description" class="form-control" rows="3">{{ old('description', $person->description) }}</textarea>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-12">
                <div class="card shadow mb-4">
                    <div class="card-body text-left">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save me-1"></i>
                            ذخیره تغییرات
                        </button>
                        <a href="{{ route('persons.show', $person) }}" class="btn btn-secondary">
                            <i class="fas fa-times me-1"></i>
                            انصراف
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>
@endsection

@push('scripts')
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="{{ asset('js/persian-date.min.js') }}"></script>
<script src="{{ asset('js/persian-datepicker.min.js') }}"></script>
<script>
$(document).ready(function() {
    // تنظیمات استان و شهر
    $('#province_select').on('change', function() {
        const provinceId = $(this).val();
        const citySelect = $('#city_select');

        if (provinceId) {
            $.get(`/persons/province/${provinceId}/cities`, function(cities) {
                citySelect.empty();
                citySelect.append('<option value="">انتخاب شهر</option>');

                cities.forEach(function(city) {
                    citySelect.append(`<option value="${city.id}">${city.text}</option>`);
                });

                // اگر شهر قبلاً انتخاب شده بود
                @if(old('city', $person->city))
                    citySelect.val('{{ old("city", $person->city) }}');
                @endif
            });
        } else {
            citySelect.empty();
            citySelect.append('<option value="">ابتدا استان را انتخاب کنید</option>');
        }
    });

    // اگر استان از قبل انتخاب شده، شهرها را لود کن
    @if(old('province', $person->province))
        $('#province_select').trigger('change');
    @endif

    // مدیریت حساب‌های بانکی
    $('#add-bank-account').click(function() {
        const bankAccountHtml = `
            <div class="bank-account-row animate-fade-in">
                <div class="mb-2">
                    <label class="form-label">نام بانک</label>
                    <input type="text" name="bank_accounts[bank_name][]" class="form-control">
                </div>
                <div class="mb-2">
                    <label class="form-label">شماره حساب</label>
                    <input type="text" name="bank_accounts[account_number][]" class="form-control">
                </div>
                <div class="mb-2">
                    <label class="form-label">شماره کارت</label>
                    <input type="text" name="bank_accounts[card_number][]" class="form-control card-number">
                </div>
                <div class="mb-2">
                    <label class="form-label">شماره شبا</label>
                    <input type="text" name="bank_accounts[iban][]" class="form-control iban">
                </div>
                <button type="button" class="btn btn-sm btn-danger remove-bank-account">
                    <i class="fas fa-times"></i>
                </button>
            </div>
        `;
        $('#bank-accounts').append(bankAccountHtml);
    });

    $(document).on('click', '.remove-bank-account', function() {
        $(this).closest('.bank-account-row').fadeOut(300, function() {
            $(this).remove();
        });
    });

    // تنظیمات تاریخ شمسی
    $('.datepicker').persianDatepicker({
        format: 'YYYY/MM/DD',
        autoClose: true,
        initialValue: false,
        persianDigit: false
    });
});
</script>
@endpush
