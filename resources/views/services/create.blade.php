@extends('layouts.app')

@section('title', 'افزودن خدمت جدید')

@section('styles')
<link rel="stylesheet" href="{{ asset('css/service-create.css') }}">
<style>
    body {
        background: linear-gradient(135deg, #f7fafc 0%, #e3eafc 100%);
        min-height: 100vh;
    }
    .card.service-card {
        border-radius: 18px;
        box-shadow: 0 8px 32px #2563eb25;
        border: none;
    }
    .service-header {
        background: linear-gradient(90deg, #2563eb 0%, #3b82f6 100%);
        color: #fff;
        border-radius: 18px 18px 0 0;
        padding: 1.5rem 2rem;
    }
    .service-header h4 {
        font-size: 1.5rem;
        font-weight: bold;
        letter-spacing: 0.04em;
        margin-bottom: 0;
    }
    .required:after {
        content: '*';
        color: #e53e3e;
        margin-right: 0.25rem;
        font-size: 1.1em;
    }
    .input-group .input-group-text {
        min-width: 120px;
        background: #e6efff;
        color: #23408c;
        font-weight: bold;
        font-size: 1em;
    }
    .form-label {
        font-weight: 700;
        color: #23408c;
        margin-bottom: .5rem;
    }
    .modal-backdrop.show { opacity: 0.2; }
    .list-group-item .unit-name { min-width: 100px; display: inline-block; }
    .preview-img {
        display: block;
        max-width: 170px;
        max-height: 120px;
        margin-top: 8px;
        border-radius: 7px;
        box-shadow: 0 2px 8px #23408c22;
        border: 1px solid #e3eafc;
    }
    .shareholder-label { min-width: 120px; }
    .btn-gradient {
        background: linear-gradient(90deg, #23408c 0%, #3b82f6 100%);
        color: #fff !important;
        border: none;
        border-radius: 6px;
        padding: 10px 30px;
        font-weight: bold;
        box-shadow: 0 2px 14px #2563eb22;
        transition: background 0.2s, box-shadow 0.2s;
    }
    .btn-gradient:hover {
        background: linear-gradient(90deg, #1e2549 0%, #2563eb 100%);
        box-shadow: 0 4px 16px #23408c33;
    }
    .form-section-title {
        font-weight: bold;
        font-size: 1.09em;
        color: #2563eb;
        margin-bottom: 0.5rem;
        margin-top: 1.5rem;
        border-bottom: 1.5px solid #e3eafc;
        padding-bottom: 0.3rem;
        letter-spacing: 0.01em;
    }
    .category-modal-list { min-height: 120px; }
    .pagination { justify-content: center; }
    .modal-backdrop.show { opacity: 0.2; }
    @media (max-width: 700px) {
        .card.service-card { padding: 0.5rem; }
        .service-header { padding: 1rem 1.1rem; font-size: 1.1rem; }
        .btn-gradient { width: 100%; }
    }
</style>
@endsection

@section('content')
<section class="container pt-5">
    <div class="row justify-content-center">
        <div class="col-lg-9 col-xl-8">
            <div class="card service-card">
                <div class="service-header d-flex align-items-center gap-2">
                    <i class="fa fa-plus-circle fa-lg"></i>
                    <h4>افزودن خدمت جدید</h4>
                </div>
                <div class="card-body p-4">
                    {{-- پیام موفقیت و خطا --}}
                    @if ($errors->any())
                        <div class="alert alert-danger animate__animated animate__shakeX">
                            <ul class="mb-0">
                                @foreach ($errors->all() as $error)
                                    <li>{{ $error }}</li>
                                @endforeach
                            </ul>
                        </div>
                    @endif
                    @if(session('success'))
                        <div class="alert alert-success animate__animated animate__fadeInDown">{{ session('success') }}</div>
                    @endif

                    <form action="{{ route('services.store') }}" method="POST" enctype="multipart/form-data" autocomplete="off">
                        @csrf

                        <div class="form-section-title">اطلاعات اصلی خدمت</div>
                        <div class="row mb-3">
                            <div class="col-md-6 mb-3">
                                <label for="title" class="form-label required">نام خدمت</label>
                                <input type="text" name="title" id="title" class="form-control form-control-lg" required autofocus value="{{ old('title') }}">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="service_code" class="form-label">کد خدمات</label>
                                <div class="input-group">
                                    <input type="text" id="service_code" name="service_code" class="form-control" required value="{{ old('service_code') }}">
                                    <span class="input-group-text">
                                        <label class="switch-edit-code mb-0" style="font-weight:normal">
                                            <input type="checkbox" id="custom_code_switch" class="form-check-input ms-1">
                                            کد دلخواه
                                        </label>
                                    </span>
                                </div>
                                <small class="text-muted d-block mt-1">کد به صورت خودکار ساخته می‌شود. برای وارد کردن کد دلخواه تیک را فعال کنید.</small>
                            </div>
                        </div>

                        <div class="row mb-3 align-items-end">
                            <div class="col-md-6 mb-3">
                                <label for="image" class="form-label">تصویر خدمت</label>
                                <input type="file" name="image" id="image" class="form-control" accept="image/*">
                                <img id="image_preview" class="preview-img" src="#" alt="پیش نمایش" style="display:none;">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="service_info" class="form-label">اطلاعات خدمات</label>
                                <input type="text" name="service_info" id="service_info" class="form-control" value="{{ old('service_info') }}">
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-6 mb-3">
                                <label for="service_category_id" class="form-label">دسته‌بندی خدمت</label>
                                <div class="input-group">
                                    <select name="service_category_id" id="service_category_id" class="form-select">
                                        <option value="">انتخاب کنید</option>
                                        @foreach($serviceCategories as $cat)
                                            <option value="{{ $cat->id }}" {{ old('service_category_id') == $cat->id ? 'selected' : '' }}>{{ $cat->name }}</option>
                                        @endforeach
                                    </select>
                                    <button type="button" class="btn btn-outline-primary" id="add-category-btn">
                                        <i class="fa fa-plus"></i>
                                    </button>
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="price" class="form-label required">مبلغ فروش (تومان)</label>
                                <input type="number" name="price" id="price" class="form-control" min="0" step="100" required value="{{ old('price') }}">
                            </div>
                        </div>

                        <div class="form-section-title">واحد خدمت</div>
                        <div class="row mb-3">
                            <div class="col-md-8 mb-3">
                                <label for="unit_id" class="form-label required">واحد خدمت</label>
                                <div class="input-group">
                                    <select name="unit_id" id="unit_id" class="form-select" required>
                                        <option value="">انتخاب واحد</option>
                                        @foreach($units as $unit)
                                            <option value="{{ $unit->id }}" {{ old('unit_id') == $unit->id ? 'selected' : '' }}>{{ $unit->title }}</option>
                                        @endforeach
                                    </select>
                                    <button type="button" class="btn btn-outline-primary" id="add-unit-btn">
                                        <i class="fa fa-plus"></i> افزودن واحد جدید
                                    </button>
                                </div>
                            </div>
                        </div>
                        <ul id="unit-list" class="list-group mb-3" style="display: none"></ul>

                        <div class="form-section-title">توضیحات و اطلاعات تکمیلی</div>
                        <div class="row mb-3">
                            <div class="col-md-6 mb-3">
                                <label for="short_description" class="form-label">توضیح کوتاه</label>
                                <input type="text" name="short_description" id="short_description" class="form-control" maxlength="255" value="{{ old('short_description') }}">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="info_link" class="form-label">صفحه/لینک اطلاعات گرفته شده</label>
                                <textarea name="info_link" id="info_link" class="form-control" rows="2">{{ old('info_link') }}</textarea>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="description" class="form-label">توضیحات</label>
                            <textarea name="description" id="description" class="form-control" rows="2">{{ old('description') }}</textarea>
                        </div>
                        <div class="mb-3">
                            <label for="full_description" class="form-label">توضیحات کامل</label>
                            <textarea name="full_description" id="full_description" class="form-control" rows="5">{{ old('full_description') }}</textarea>
                        </div>

                        <div class="mb-3 form-check form-switch">
                            <input class="form-check-input" type="checkbox" id="is_active" name="is_active" value="1" {{ old('is_active', true) ? 'checked' : '' }}>
                            <label class="form-check-label" for="is_active">فعال باشد</label>
                        </div>

                        <div class="form-section-title">سهامداران و درصد هرکدام</div>
                        <div class="mb-4">
                            <div class="row">
                                @foreach($shareholders as $shareholder)
                                <div class="col-md-4 mb-2">
                                    <div class="input-group">
                                        <div class="input-group-text shareholder-label">{{ $shareholder->full_name }}</div>
                                        <input type="number"
                                               class="form-control"
                                               name="shareholders[{{ $shareholder->id }}]"
                                               min="0"
                                               max="100"
                                               step="0.01"
                                               value="{{ old('shareholders.'.$shareholder->id, '') }}"
                                               placeholder="درصد سهم">
                                        <span class="input-group-text">%</span>
                                    </div>
                                </div>
                                @endforeach
                            </div>
                            <small class="text-muted">درصد سهام هرکدام را وارد کنید. اگر سهامداری در این خدمت سهم ندارد، مقدار را خالی بگذارید یا صفر وارد کنید.</small>
                        </div>

                        <div class="d-flex justify-content-end mt-3">
                            <button type="submit" class="btn btn-gradient px-4">
                                <i class="fa fa-save me-1"></i>ثبت خدمت
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Modal افزودن واحد جدید -->
<div class="modal fade" id="addUnitModal" tabindex="-1" aria-labelledby="addUnitModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <form id="add-unit-form" class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addUnitModalLabel">افزودن واحد جدید</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="بستن"></button>
            </div>
            <div class="modal-body">
                <input type="text" id="new-unit-input" class="form-control mb-2" placeholder="نام واحد جدید" required>
                <input type="hidden" id="edit-unit-id">
                <ul id="unit-modal-list" class="list-group mt-2"></ul>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                    انصراف
                </button>
                <button type="submit" class="btn btn-primary">
                    ثبت واحد
                </button>
            </div>
        </form>
    </div>
</div>

<!-- Modal افزودن دسته‌بندی جدید -->
<div class="modal fade" id="addCategoryModal" tabindex="-1" aria-labelledby="addCategoryModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <form id="add-category-form" autocomplete="off">
                <div class="modal-header">
                    <h5 class="modal-title" id="addCategoryModalLabel">افزودن دسته‌بندی جدید</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="بستن"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <input type="text" id="new-category-name" class="form-control" placeholder="نام دسته‌بندی جدید" required>
                    </div>
                    <button type="submit" class="btn btn-success mb-3">ثبت دسته‌بندی</button>
                    <hr>
                    <div id="category-list-section">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <span style="font-weight:bold;">لیست دسته‌بندی‌ها</span>
                            <div>
                                <button type="button" class="btn btn-sm btn-outline-secondary" id="prev-cat-page">قبلی</button>
                                <span id="cat-page-info" style="font-size:1em;">صفحه <span id="cat-current-page">1</span></span>
                                <button type="button" class="btn btn-sm btn-outline-secondary" id="next-cat-page">بعدی</button>
                            </div>
                        </div>
                        <ul id="category-modal-list" class="list-group category-modal-list"></ul>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
@endsection

@section('scripts')
<script src="{{ asset('js/service-create.js') }}"></script>
<script>
document.addEventListener('DOMContentLoaded', function () {
    // مقداردهی اولیه کد خدمت
    let codeInput = document.getElementById('service_code');
    let customSwitch = document.getElementById('custom_code_switch');
    let loadingCode = false;
    function fetchNextCode() {
        if(loadingCode) return;
        loadingCode = true;
        fetch('/services/next-code')
            .then(res => res.json())
            .then(data => {
                codeInput.value = data.code;
                codeInput.readOnly = true;
                loadingCode = false;
            }).catch(() => {
                codeInput.value = '';
                loadingCode = false;
            });
    }
    fetchNextCode();
    customSwitch.addEventListener('change', function() {
        if(customSwitch.checked) {
            codeInput.readOnly = false;
            codeInput.value = '';
            codeInput.focus();
        } else {
            fetchNextCode();
        }
    });

    // پیش‌نمایش تصویر
    const imageInput = document.getElementById('image');
    const imagePreview = document.getElementById('image_preview');
    if(imageInput && imagePreview){
        imageInput.addEventListener('change', function() {
            if (imageInput.files && imageInput.files[0]) {
                var reader = new FileReader();
                reader.onload = function(e) {
                    imagePreview.style.display = "block";
                    imagePreview.src = e.target.result;
                }
                reader.readAsDataURL(imageInput.files[0]);
            }
        });
    }

    // مدیریت دسته‌بندی خدمات (پاپ‌آپ و صفحه‌بندی)
    const addCategoryBtn = document.getElementById('add-category-btn');
    const addCategoryModal = document.getElementById('addCategoryModal');
    const addCategoryForm = document.getElementById('add-category-form');
    const newCategoryInput = document.getElementById('new-category-name');
    const categorySelect = document.getElementById('service_category_id');
    const categoryModalList = document.getElementById('category-modal-list');
    const prevCatPageBtn = document.getElementById('prev-cat-page');
    const nextCatPageBtn = document.getElementById('next-cat-page');
    const catPageInfo = document.getElementById('cat-current-page');
    let catCurrentPage = 1;
    let catLastPage = 1;

    function fetchCategoryPage(page = 1) {
        fetch(`/api/categories?page=${page}&type=service`)
            .then(res => res.json())
            .then(data => {
                categoryModalList.innerHTML = '';
                data.data.forEach(cat => {
                    let li = document.createElement('li');
                    li.className = 'list-group-item d-flex justify-content-between align-items-center p-2';
                    li.innerHTML = `
                        <span>${cat.name}</span>
                        <button type="button" class="btn btn-sm btn-outline-primary select-cat-btn" data-cat-id="${cat.id}" data-cat-name="${cat.name}">انتخاب</button>
                    `;
                    categoryModalList.appendChild(li);
                });
                catCurrentPage = data.current_page;
                catLastPage = data.last_page;
                catPageInfo.textContent = catCurrentPage;
                prevCatPageBtn.disabled = catCurrentPage <= 1;
                nextCatPageBtn.disabled = catCurrentPage >= catLastPage;
            });
    }

    if(addCategoryBtn && addCategoryModal){
        addCategoryBtn.addEventListener('click', function() {
            newCategoryInput.value = '';
            fetchCategoryPage(1);
            $('#addCategoryModal').modal('show');
        });
    }

    addCategoryForm.addEventListener('submit', function(e){
        e.preventDefault();
        let name = newCategoryInput.value.trim();
        if(!name) return;
        fetch('/categories', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRF-TOKEN': document.querySelector('input[name="_token"]').value
            },
            body: JSON.stringify({ name })
        })
        .then(res => res.json())
        .then(data => {
            if(data && data.id && data.name){
                // به سلکت اصلی اضافه و انتخاب شود
                let opt = document.createElement('option');
                opt.value = data.id;
                opt.text = data.name;
                categorySelect.appendChild(opt);
                categorySelect.value = data.id;
                fetchCategoryPage(catCurrentPage);
                newCategoryInput.value = '';
            }else{
                alert('خطا در ثبت دسته‌بندی!');
            }
        });
    });

    prevCatPageBtn.addEventListener('click', function(){
        if(catCurrentPage > 1) fetchCategoryPage(catCurrentPage - 1);
    });
    nextCatPageBtn.addEventListener('click', function(){
        if(catCurrentPage < catLastPage) fetchCategoryPage(catCurrentPage + 1);
    });

    categoryModalList.addEventListener('click', function(e){
        if(e.target.classList.contains('select-cat-btn')){
            let catId = e.target.getAttribute('data-cat-id');
            let catName = e.target.getAttribute('data-cat-name');
            // افزودن به سلکت اگر نبود
            let exists = false;
            for(let i=0; i<categorySelect.options.length; i++) {
                if(categorySelect.options[i].value == catId) exists = true;
            }
            if(!exists){
                let opt = document.createElement('option');
                opt.value = catId;
                opt.text = catName;
                categorySelect.appendChild(opt);
            }
            categorySelect.value = catId;
            $('#addCategoryModal').modal('hide');
        }
    });

    
});
</script>
@endsection
