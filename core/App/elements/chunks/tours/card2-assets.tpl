<style>
    /* ── card2 ─────────────────────────────────────────────── */
    .tc2-card {
        border-radius: 16px;
        overflow: hidden;
        background: #fff;
        box-shadow: 0 1px 6px rgba(0,0,0,.08);
        transition: box-shadow .25s, transform .25s;
        height: 100%;
        display: flex;
        flex-direction: column;
    }
    .tc2-card:hover {
        box-shadow: 0 8px 28px rgba(0,0,0,.13);
        transform: translateY(-3px);
    }
    .tc2-gallery {
        position: relative;
        display: block;
        overflow: hidden;
        aspect-ratio: 16/10;
        text-decoration: none;
        background: #d1d5db;
        flex-shrink: 0;
    }
    .tc2-slide {
        position: absolute;
        inset: 0;
        opacity: 0;
        transition: opacity .35s ease;
    }
    .tc2-slide.active { opacity: 1; }
    .tc2-slide img {
        width: 100%; height: 100%;
        object-fit: cover;
        display: block;
    }
    .tc2-counter {
        position: absolute;
        top: 10px; left: 10px;
        z-index: 3;
        background: rgba(0,0,0,.45);
        backdrop-filter: blur(6px);
        color: #fff;
        font-size: 12px;
        font-weight: 700;
        padding: 3px 10px;
        border-radius: 20px;
    }
    .tc2-guide-badge {
        position: absolute;
        top: 10px; right: 10px;
        z-index: 3;
        cursor: default;
    }
    .tc2-guide-avatar {
        width: 36px; height: 36px;
        border-radius: 50%;
        object-fit: cover;
        border: 2px solid rgba(255,255,255,.8);
        box-shadow: 0 2px 8px rgba(0,0,0,.25);
        display: block;
    }
    .tc2-guide-tooltip {
        position: absolute;
        right: 44px;
        top: 50%;
        transform: translateY(-50%);
        background: rgba(0,0,0,.75);
        color: #fff;
        font-size: 12px;
        white-space: nowrap;
        padding: 4px 10px;
        border-radius: 6px;
        pointer-events: none;
        opacity: 0;
        transition: opacity .2s;
    }
    .tc2-guide-tooltip::after {
        content: '';
        position: absolute;
        left: 100%;
        top: 50%;
        transform: translateY(-50%);
        border: 5px solid transparent;
        border-left-color: rgba(0,0,0,.75);
    }
    .tc2-guide-badge:hover .tc2-guide-tooltip {
        opacity: 1;
    }
    .tc2-nav {
        position: absolute;
        top: 50%;
        transform: translateY(-50%);
        z-index: 3;
        background: rgba(255,255,255,.9);
        border: none;
        color: #374151;
        width: 32px; height: 32px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 22px;
        line-height: 1;
        cursor: pointer;
        opacity: 0;
        transition: opacity .2s;
        padding: 0;
        box-shadow: 0 1px 4px rgba(0,0,0,.2);
    }
    .tc2-gallery:hover .tc2-nav { opacity: 1; }
    .tc2-prev { left: 10px; }
    .tc2-next { right: 10px; }
    .tc2-dots {
        position: absolute;
        bottom: 10px;
        left: 50%;
        transform: translateX(-50%);
        z-index: 3;
        display: flex;
        gap: 5px;
    }
    .tc2-dot {
        width: 6px; height: 6px;
        border-radius: 50%;
        background: rgba(255,255,255,.55);
        transition: background .2s, transform .2s;
    }
    .tc2-dot.active {
        background: #fff;
        transform: scale(1.3);
    }
    .tc2-body {
        padding: 14px 16px 16px;
        display: flex;
        flex-direction: column;
        flex: 1;
    }
    .tc2-title {
        font-size: 15px;
        font-weight: 700;
        color: #111827;
        margin: 0 0 10px;
        line-height: 1.35;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        overflow: hidden;
    }
    .tc2-info-row {
        display: flex;
        align-items: center;
        gap: 5px;
        font-size: 13px;
        color: #374151;
        margin-bottom: 5px;
    }
    .tc2-icon { flex-shrink: 0; color: #6b7280; }
    .tc2-extra-dates { color: #2563eb; font-weight: 600; text-decoration: none; }
    .tc2-extra-dates:hover { text-decoration: underline; }
    .tc2-dot-green, .tc2-dot-orange, .tc2-dot-red, .tc2-dot-gray {
        display: inline-block;
        width: 8px; height: 8px;
        border-radius: 50%;
        flex-shrink: 0;
    }
    .tc2-dot-green  { background: #22c55e; }
    .tc2-dot-orange { background: #f97316; }
    .tc2-dot-red    { background: #ef4444; }
    .tc2-dot-gray   { background: #9ca3af; }
    .tc2-text-orange { color: #f97316; }
    .tc2-text-red    { color: #ef4444; }
    .tc2-text-gray   { color: #9ca3af; }
    .tc2-btn-queue {
        border: 1px solid #d1d5db;
        background: transparent;
        color: #9ca3af;
    }
    .tc2-btn-queue:hover { background: #f3f4f6; color: #6b7280; }
    .tc2-footer {
        margin-top: auto;
        padding-top: 12px;
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 8px;
    }
    .tc2-price {
        font-size: 18px;
        font-weight: 800;
        color: #111827;
        white-space: nowrap;
        text-align: right;
    }
    .tc2-price-old {
        font-size: 12px;
        font-weight: 400;
        text-decoration: line-through;
        color: #9ca3af;
        display: block;
        text-align: right;
    }
    /* ── end card2 ─────────────────────────────────────────── */
</style>
<script>
    (function () {
        function initTc2Sliders() {
            document.querySelectorAll('[id^="tc-"]').forEach(card => {
                if (card._tc2init) return;
                card._tc2init = true;
                const slides = card.querySelectorAll('.tc2-slide');
                const dots   = card.querySelectorAll('.tc2-dot');
                if (slides.length <= 1) return;
                let cur = 0;
                function goTo(n) {
                    slides[cur].classList.remove('active');
                    dots[cur]?.classList.remove('active');
                    cur = (n + slides.length) % slides.length;
                    slides[cur].classList.add('active');
                    dots[cur]?.classList.add('active');
                }
                card.querySelector('.tc2-prev')?.addEventListener('click', e => { e.preventDefault(); e.stopPropagation(); goTo(cur - 1); });
                card.querySelector('.tc2-next')?.addEventListener('click', e => { e.preventDefault(); e.stopPropagation(); goTo(cur + 1); });
            });
        }
        document.addEventListener('DOMContentLoaded', initTc2Sliders);
        document.addEventListener('pb:after', initTc2Sliders);
    })();
</script>
