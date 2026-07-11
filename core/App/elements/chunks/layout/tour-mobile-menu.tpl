<style>
.tmn {
    display: none;
    position: fixed;
    bottom: 0; left: 0; right: 0;
    z-index: 1040;
    background: #1c1c1e;
    border-top: 1px solid rgba(255,255,255,.08);
    box-shadow: 0 -4px 24px rgba(0,0,0,.35);
    padding-bottom: env(safe-area-inset-bottom);
    -webkit-transform: translateZ(0);
    transform: translateZ(0);
    will-change: transform;
    -webkit-backface-visibility: hidden;
    backface-visibility: hidden;
}
@media (max-width: 991px) { .tmn { display: block; } }

.tmn__list {
    display: flex;
    overflow-x: auto;
    overflow-y: hidden;
    scroll-snap-type: x mandatory;
    -webkit-overflow-scrolling: touch;
    scrollbar-width: none;
    margin: 0; padding: 0;
    list-style: none;
}
.tmn__list::-webkit-scrollbar { display: none; }

.tmn__item { flex-shrink: 0; scroll-snap-align: start; }

.tmn__link {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    gap: 4px;
    padding: 10px 14px 9px;
    min-width: 68px;
    text-decoration: none;
    color: rgba(255,255,255,.45);
    font-size: 10px;
    font-weight: 600;
    letter-spacing: .3px;
    white-space: nowrap;
    border-bottom: 2px solid transparent;
    transition: color .18s, border-color .18s;
    -webkit-tap-highlight-color: transparent;
    user-select: none;
}
.tmn__link svg {
    width: 20px; height: 20px;
    flex-shrink: 0;
    transition: transform .18s;
}
.tmn__link:active svg { transform: scale(.88); }
.tmn__link.active,
.tmn__link:hover {
    color: #20C19C;
    border-bottom-color: #20C19C;
}
.tmn__link--cta {
    color: #fff;
    background: #e94560;
    border-radius: 8px;
    margin: 7px 8px 7px 4px;
    padding: 7px 14px;
    border-bottom: none;
    font-size: 11px;
}
.tmn__link--cta:hover,
.tmn__link--cta:active { color: #fff; background: #c93550; border-bottom-color: transparent; }
</style>

<nav class="tmn" aria-label="Навигация по туру">
    <ul class="tmn__list">
        <li class="tmn__item">
            <a class="tmn__link" href="{$modx->resource->uri}#about">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>
                Описание
            </a>
        </li>
        <li class="tmn__item">
            <a class="tmn__link" href="{$modx->resource->uri}#days">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="4" width="18" height="18" rx="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/></svg>
                Программа
            </a>
        </li>
        <li class="tmn__item">
            <a class="tmn__link" href="{$modx->resource->uri}#team">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>
                Гиды
            </a>
        </li>
        <li class="tmn__item">
            <a class="tmn__link" href="{$modx->resource->uri}#price">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><line x1="12" y1="1" x2="12" y2="23"/><path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"/></svg>
                Стоимость
            </a>
        </li>
        <li class="tmn__item">
            <a class="tmn__link" href="{$modx->resource->uri}#reviews">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/></svg>
                Отзывы
            </a>
        </li>
        <li class="tmn__item">
            <a class="tmn__link" href="{$modx->resource->uri}#equipment">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M4 15s1-1 4-1 5 2 8 2 4-1 4-1V3s-1 1-4 1-5-2-8-2-4 1-4 1z"/><line x1="4" y1="22" x2="4" y2="15"/></svg>
                Снаряга
            </a>
        </li>
        <li class="tmn__item">
            <a class="tmn__link" href="{$modx->resource->uri}#faq">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><path d="M9.09 9a3 3 0 0 1 5.83 1c0 2-3 3-3 3"/><line x1="12" y1="17" x2="12.01" y2="17"/></svg>
                FAQ
            </a>
        </li>
        <li class="tmn__item">
            <a class="tmn__link tmn__link--cta" href="{$modx->resource->uri}#booking">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><polyline points="20 6 9 17 4 12"/></svg>
                Записаться
            </a>
        </li>
    </ul>
</nav>

<script>
(function () {
    const nav = document.querySelector('.tmn');
    // Перемещаем в body чтобы position:fixed не ломался из-за transform на родителях
    if (nav && nav.parentElement !== document.body) {
        document.body.appendChild(nav);
    }
    const list = nav && nav.querySelector('.tmn__list');
    if (!nav || !list) return;

    // Скрываем пункты меню для разделов, которых нет на странице
    list.querySelectorAll('.tmn__item').forEach(li => {
        const a = li.querySelector('.tmn__link:not(.tmn__link--cta)');
        if (!a) return;
        const hash = a.getAttribute('href').split('#')[1];
        if (hash && !document.getElementById(hash)) {
            li.style.display = 'none';
        }
    });

    // visualViewport: фиксируем меню к низу реального viewport на iOS
    if (window.visualViewport) {
        function repositionNav() {
            const vv = window.visualViewport;
            const offset = window.innerHeight - vv.height - vv.offsetTop;
            nav.style.transform = 'translateZ(0) translateY(' + Math.max(0, offset) + 'px)';
        }
        window.visualViewport.addEventListener('resize', repositionNav, { passive: true });
        window.visualViewport.addEventListener('scroll', repositionNav, { passive: true });
        repositionNav();
    }

    // Scrollspy: подсветка активного раздела
    const links = list.querySelectorAll('.tmn__link:not(.tmn__link--cta)');
    const sections = [];
    links.forEach(a => {
        const hash = a.getAttribute('href').split('#')[1];
        if (hash) {
            const el = document.getElementById(hash);
            if (el) sections.push({ el, a });
        }
    });

    function setActive(link) {
        links.forEach(l => l.classList.remove('active'));
        link.classList.add('active');
        const li = link.closest('li');
        list.scrollTo({ left: li.offsetLeft - 8, behavior: 'smooth' });
    }

    // Bootstrap scrollspy event
    document.addEventListener('activate.bs.scrollspy', e => {
        const href = e.relatedTarget && e.relatedTarget.getAttribute('href');
        if (!href) return;
        const hash = href.split('#')[1];
        const match = Array.from(links).find(l => l.getAttribute('href').endsWith('#' + hash));
        if (match) setActive(match);
    });

    // Fallback: IntersectionObserver
    if ('IntersectionObserver' in window && sections.length) {
        const io = new IntersectionObserver(entries => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const found = sections.find(s => s.el === entry.target);
                    if (found) setActive(found.a);
                }
            });
        }, { rootMargin: '-40% 0px -55% 0px', threshold: 0 });
        sections.forEach(s => io.observe(s.el));
    }

    // Плавный клик (предотвращаем drag-click)
    let dragDist = 0, touchStartX = 0;
    list.addEventListener('touchstart', e => { touchStartX = e.touches[0].clientX; dragDist = 0; }, { passive: true });
    list.addEventListener('touchmove', e => { dragDist = Math.abs(e.touches[0].clientX - touchStartX); }, { passive: true });
    list.querySelectorAll('.tmn__link').forEach(a => {
        a.addEventListener('click', e => { if (dragDist > 6) e.preventDefault(); });
    });
})();
</script>
