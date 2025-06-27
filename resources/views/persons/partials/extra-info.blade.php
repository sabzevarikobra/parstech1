<div class="row g-3">
    <div class="col-md-4">
        <div class="form-group">
            <label class="form-label">تاریخ تولد</label>
            <input type="text" name="birth_date" class="form-control datepicker"
                   value="{{ old('birth_date') }}" autocomplete="off">
        </div>
    </div>

    <div class="col-md-4">
        <div class="form-group">
            <label class="form-label">تاریخ ازدواج</label>
            <input type="text" name="marriage_date" class="form-control datepicker"
                   value="{{ old('marriage_date') }}" autocomplete="off">
        </div>
    </div>

    <div class="col-md-4">
        <div class="form-group">
            <label class="form-label">تاریخ عضویت</label>
            <input type="text" name="join_date" class="form-control datepicker"
                   value="{{ old('join_date', date('Y/m/d')) }}" autocomplete="off">
        </div>
    </div>

    <div class="col-md-4">
        <div class="form-group">
            <label class="form-label">کد اقتصادی</label>
            <input type="text" name="economic_code" class="form-control"
                   value="{{ old('economic_code') }}">
        </div>
    </div>

    <div class="col-md-4">
        <div class="form-group">
            <label class="form-label">شماره ثبت</label>
            <input type="text" name="registration_number" class="form-control"
                   value="{{ old('registration_number') }}">
        </div>
    </div>

    <div class="col-md-4">
        <div class="form-group">
            <label class="form-label">اعتبار مالی (ریال)</label>
            <input type="number" name="credit_limit" class="form-control"
                   value="{{ old('credit_limit', 0) }}">
        </div>
    </div>

    <div class="col-md-12">
        <div class="form-group">
            <label class="form-label">توضیحات</label>
            <textarea name="description" class="form-control"
                      rows="4">{{ old('description') }}</textarea>
        </div>
    </div>
</div>
