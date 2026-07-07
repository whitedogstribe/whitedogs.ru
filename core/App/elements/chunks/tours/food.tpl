<section class="food-section">
    <div class="food-hero position-relative overflow-hidden pb-3 mb-3 pb-md-5 mb-md-5">
        <div class="position-absolute inset-0 bg-center bg-cover">
            <img loading="lazy" src="/assets/images/content/menu/pohod-food-bg.7a44b0010926b73e0a7dca3c68e5e45d.jpg" width="1200" class="w-100 h-100 object-fit-cover" alt="Что едим в походе" loading="lazy" decoding="async">
        </div>
        <div class="position-absolute overflow-hidden start-0 w-100 text-white" style="top:-2px">
            <svg height="auto" width="100%" class="svg-section-top" data-icon="section-slope" viewBox="0 0 2202 240">
                <use href="#section-slope"></use>
            </svg>
        </div>
        <div class="food-hero-content text-white position-relative d-flex flex-wrap gap-2">
            <div class="col-12 col-lg-6">
                <h2 class="h3 food-hero-title font-cofo text-center text-lg-end text-uppercase">Что <br>едим</h2>
            </div>
            <div class="d-none d-lg-block position-absolute text-center top-0 start-0 end-0 mx-auto">
                <img src="/assets/images/content/menu/pohod-food-image.369115ba7f191be381ec5c5c8eb6f5d1.webp" alt="">
            </div>
            <div class="col-12 col-lg-2 food-hero-text">
                <div class="text-sm">
                    Еда на маршруте – это то, чему мы всегда уделяем особое внимание. Виды, дымки рано утром, панорамы гор – это все безусловно хорошо, но кому есть до
                    этого дело на пустой желудок?
                </div>
            </div>
        </div>
        <div class="position-absolute overflow-hidden start-0 w-100 text-white" style="bottom:-2px">
            <svg height="auto" width="100%" data-icon="section-slope" viewBox="0 0 2202 240">
                <use href="#section-slope"></use>
            </svg>
        </div>
    </div>

    {set $food = query('pb_block_data')
        ->select('data')
        ->where('id', 775)
        ->value('data')|fromJSON}

    <div class="container">
        <div class="row">
            <div class="col-12 col-xl-8 mx-auto text-center mb-5 px-4">
                {if $modx->resource->food_title}
                    <h2 class="header-title h1 font-cofo text-uppercase mb-3">{$modx->resource->food_title}</h2>
                {else}
                    <h2 class="header-title h1 font-cofo text-uppercase mb-3">НЕ ПОХОДНОЕ меню «{$modx->resource->menutitle}»</h2>
                {/if}
                <p class="header-description">{$modx->resource->food_desc ?: $food['description']}</p>
                <div class="d-block d-md-none position-relative">
                    {insert 'file:chunks/layout/icon-scroll.tpl'}
                </div>
            </div>
        </div>

        {set $items = $modx->resource->food}
        {if !$items}
            {set $results = query('pb_table_data')
            ->select('data')
            ->where([
                'field_id' => 104,
                'model_id' => 775,
            ])
            ->whereNotNull('published_at')
            ->where('published_at', '<=', now())
            ->whereNull('deleted_at')
            ->get()
            ->toArray()}

            {set $items = []}
            {foreach $results as $i}
                {set $items[] = $i->data|fromJSON}
            {/foreach}
        {/if}

        <div class="f-carousel f-carousel-mobile" id="food-carousel">
            <div class="f-carousel__viewport">
                {foreach $items as $item}
                    {set $img = $item.img|fromJSON}
                    <div class="food-item f-carousel__slide d-flex flex-column gap-2 mb-4">
                        <img loading="lazy"
                             src="{$img.url|glide:'w=304&h=229&fit=crop&fm=webp'}"
                             width="304"
                             height="229"
                             class="img-fluid"
                             alt="{$item.title|notags}">
                        <div class="d-flex gap-2">
                            <span class="badge rounded-pill text-uppercase">{$item.type}</span>
                        </div>
                        <h3 class="h6 fw-semibold">{$item.title}</h3>
                        {$item.description}
                    </div>
                {/foreach}
            </div>
        </div>
    </div>
    <style>
        .food-hero-content {
            padding: 0 0 80px;
        }
        .food-hero-title {
            font-size: 60px;
            line-height: 60px;
            padding-right: 120px;
            padding-top: 140px;
        }
        .food-hero-text {
            margin-left: 10rem;
            padding-top: 120px;
            font-size: 14px;
            font-weight: 500;
            line-height: 20px;
            max-width: 208px;
        }
        .food-item {
            max-width: 304px;
        }
        .food-item p {
            font-size: .875rem;
            line-height: 1.25rem;
        }
        @media (max-width: 991px) {
            .food-hero-content {
                padding: 50px 0;
            }
            .food-hero-title {
                padding: 0;
            }
            .food-hero-text {
                margin: auto 0 0;
                padding: 0 24px;
                max-width: 100%;
                text-align: center;
                position: relative;
                z-index: 1;
            }
        }
        @media (min-width: 768px) and (max-width: 1399.98px) {
            #food-carousel .f-carousel__viewport{
                max-width: 740px;
            }
        }
    </style>
</section>