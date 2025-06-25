document.addEventListener('DOMContentLoaded', function() {
    // متغیرهای مورد نیاز
    const sidebar = document.getElementById('sidebar');
    const sidebarCollapse = document.getElementById('sidebarCollapse');
    const submenuItems = document.querySelectorAll('.has-submenu');

    // باز و بسته کردن سایدبار
    if (sidebarCollapse) {
        sidebarCollapse.addEventListener('click', () => {
            sidebar.classList.toggle('collapsed');
            localStorage.setItem('sidebarCollapsed', sidebar.classList.contains('collapsed'));
        });
    }

    // بازیابی وضعیت قبلی سایدبار
    const sidebarState = localStorage.getItem('sidebarCollapsed');
    if (sidebarState === 'true') {
        sidebar.classList.add('collapsed');
    }

    // مدیریت زیرمنوها
    submenuItems.forEach(item => {
        const link = item.querySelector('.nav-link');
        link.addEventListener('click', (e) => {
            e.preventDefault();

            // بستن سایر زیرمنوهای باز
            submenuItems.forEach(other => {
                if (other !== item && other.classList.contains('open')) {
                    other.classList.remove('open');
                }
            });

            item.classList.toggle('open');
        });
    });

    // بستن زیرمنوها با کلیک خارج از آنها
    document.addEventListener('click', (e) => {
        if (!e.target.closest('.has-submenu')) {
            submenuItems.forEach(item => {
                item.classList.remove('open');
            });
        }
    });

    // نمایش منوی فعال
    const currentPath = window.location.pathname;
    const menuLinks = document.querySelectorAll('.nav-link, .submenu a');

    menuLinks.forEach(link => {
        if (link.getAttribute('href') === currentPath) {
            link.classList.add('active');
            const parentItem = link.closest('.has-submenu');
            if (parentItem) {
                parentItem.classList.add('open');
            }
        }
    });

    // پشتیبانی از تاچ
    let touchStartX = 0;
    let touchEndX = 0;

    sidebar.addEventListener('touchstart', e => {
        touchStartX = e.changedTouches[0].screenX;
    }, false);

    sidebar.addEventListener('touchend', e => {
        touchEndX = e.changedTouches[0].screenX;
        handleSwipe();
    }, false);

    function handleSwipe() {
        const SWIPE_THRESHOLD = 50;
        const diff = touchStartX - touchEndX;

        if (Math.abs(diff) > SWIPE_THRESHOLD) {
            if (diff > 0) {
                // کشیدن به چپ
                sidebar.classList.add('collapsed');
            } else {
                // کشیدن به راست
                sidebar.classList.remove('collapsed');
            }
            localStorage.setItem('sidebarCollapsed', sidebar.classList.contains('collapsed'));
        }
    }

    // پشتیبانی از کلیدهای میانبر
    document.addEventListener('keydown', (e) => {
        // Alt + S برای باز/بسته کردن سایدبار
        if (e.altKey && e.key === 's') {
            sidebar.classList.toggle('collapsed');
            localStorage.setItem('sidebarCollapsed', sidebar.classList.contains('collapsed'));
        }
    });
});
