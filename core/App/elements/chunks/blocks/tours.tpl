{insert 'file:chunks/svg.tpl'}
<section class="tours py-5 mt-5">
    <div class="container">
        <div class="row">
            <div class="col-12 col-xl-6 mx-auto mb-3">
                <h1 class="font-cofo text-center text-uppercase mb-3">{$modx->resource->longtitle ?: $modx->resource->title}</h1>
            </div>
        </div>
        <div class="row">
            <div class="col">
                <div class="row align-items-start flex-column-reverse flex-lg-row">
                    <div class="col-12 mb-4">
                        <div class="d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-2 tours-toolbar">

                            <div class="fw-semibold tours-count">
                                Найдено: <span id="toursCount" pb-total>{$total}</span> {$total|decl:'тур|тура|туров'}
                            </div>

                            <div class="d-flex flex-wrap align-items-center gap-2">

                                <button class="btn btn-outline-dark d-lg-none tours-filter-btn"
                                        data-bs-toggle="modal"
                                        data-bs-target="#modal-filter">
                                    <i class="bi bi-sliders"></i>
                                </button>

                                {insert 'file:chunks/tours/sorting.tpl'}

                                <div class="btn-group view-toggle" role="group">
                                    <a
                                            href="/tours"
                                            class="btn {$modx->resource->alias == 'tours' ? 'btn-success active' : 'btn-outline-secondary'}"
                                            data-view="grid"
                                            title="Карточки">
                                        <i class="bi bi-grid-3x2-gap-fill"></i>
                                    </a>
                                    <a
                                            href="/calendar"
                                            class="btn {$modx->resource->alias == 'calendar' ? 'btn-success active' : 'btn-outline-secondary'}"
                                            data-view="list"
                                            title="Список">
                                        <i class="bi bi-list"></i>
                                    </a>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>

                {if $modx->resource->alias == 'tours'}
                    <div class="row row-cols-1 row-cols-md-2 row-cols-xl-3 g-3 mb-5" id="pb-items">
                        {insert 'file:chunks/tours/items.tpl'}
                    </div>

                    {insert 'file:chunks/layout/loadmore.tpl'}
                {else}
                    <div class="row mb-5">
                        <div class="col-12" id="pb-items">
                            {insert 'file:chunks/tours/items.tpl'}
                        </div>
                    </div>
                {/if}
            </div>

            <div class="d-none d-lg-block col-lg-auto tours-sidebar">
                {insert 'file:chunks/tours/filter.tpl'}
            </div>
        </div>
    </div>
    {insert 'file:chunks/tours/card2-assets.tpl'}
    <style>
        /* ── tours page overrides ───────────────────────────────── */
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

        /* gallery */
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

        /* counter badge top-left */
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

        /* bookmark top-right */
        .tc2-bookmark {
            position: absolute;
            top: 10px; right: 10px;
            z-index: 3;
            background: rgba(255,255,255,.25);
            backdrop-filter: blur(6px);
            color: #fff;
            width: 32px; height: 32px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        /* nav arrows */
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

        /* dots */
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

        /* body */
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
        .tc2-icon {
            flex-shrink: 0;
            color: #6b7280;
        }
        .tc2-extra-dates {
            color: #2563eb;
            font-weight: 600;
            text-decoration: none;
        }
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
        /* ── end tours page overrides ───────────────────────────── */
    </style>

    <script>
        document.addEventListener('DOMContentLoaded', () => {
            document.querySelectorAll('.tour-card').forEach(card => {

                const priceEl = card.querySelector('.tour-price');
                const peopleEl = card.querySelector('.tour-people');
                const maxPeopleEl = card.querySelector('.tour-maxpeople');
                const select = card.querySelector('.tour-date');

                if (select) {
                    select.addEventListener('change', function (el) {
                        const option = this.options[this.selectedIndex];
                        if (priceEl) {
                            priceEl.textContent = option.dataset.price;
                        }
                        if (peopleEl) {
                            peopleEl.textContent = option.dataset.people;
                        }
                        if (maxPeopleEl) {
                            maxPeopleEl.textContent = option.dataset.maxpeople;
                        }
                    });
                }
            });

            document.addEventListener('pb:before', (e) => {
                let { form } = e.detail;
                if (form && form.id === 'form-filter') {
                    let modalFilter = document.getElementById('modal-filter');
                    if (modalFilter) {
                        let modal = bootstrap.Modal.getInstance(modalFilter);
                        if (modal) modal.hide();
                    }
                }
            });
        })
    </script>
</section>