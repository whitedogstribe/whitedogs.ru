<section class="plan-section pt-4 pb-3 pb-md-5" id="days">
    <div class="container-fluid">
        <div class="d-flex flex-wrap">
            <div class="col-12 col-md-8 mx-auto text-center mb-5 px-4">
                <h2 class="header-title h1 font-cofo text-uppercase mb-3">{$modx->resource->plan_title ?: "ПЛАН ПОХОДА"}</h2>
                {if $modx->resource->plan_subtitle}
                    <h3 class="header-subtitle h5 fw-normal">{$modx->resource->plan_subtitle}</h3>
                {/if}
                {if $modx->resource->plan_desc}
                    <p class="header-description">{$modx->resource->plan_desc}</p>
                {/if}
                <div class="d-block d-md-none">
                    {insert 'file:chunks/layout/icon-scroll.tpl'}
                </div>
            </div>
        </div>

        <div class="f-carousel f-carousel-mobile" id="plan-carousel">
            <div class="f-carousel__viewport gap-md-4">
                {foreach $modx->resource->plan as $idx => $item}
                    {set $data = $item->data}
                    {set $img = $data['gallery'][0]}
                    <div class="plan-item f-carousel__slide">
                        {insert 'file:chunks/tours/planitem.tpl'}
                    </div>
                {/foreach}
            </div>
        </div>

    </div>
    <style>
        #plan-carousel {
            --f-carousel-gap: 32px;
        }
        .plan-item {
            width: 100%;
            max-width: 472px;
        }
        .plan-item p,
        .plan-item small {
            color: var(--color-charcoal)
        }
    </style>
</section>