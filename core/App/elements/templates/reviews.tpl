{extends 'file:templates/base.tpl'}

{block 'content'}
    <section class="reviews-section mt-5 py-4">
        <div class="container">
            <div class="row">
                <div class="col-12 mb-4">
                    {set $crumbs=[['title'=>'Отзывы','url'=>'']]}
                    {insert 'file:chunks/breadcrumbs.tpl'}
                    <h1 class="font-cofo text-uppercase">{$modx->resource->longtitle ?: $modx->resource->pagetitle}</h1>
                    {if $modx->resource->description}
                        <p>{$modx->resource->description}</p>
                    {/if}
                </div>
            </div>
            <div class="row mb-5">
                <div class="col-12">
                </div>
            </div>
            <div id="pb-items">
                {insert 'file:chunks/reviews/items.tpl'}
            </div>
            {insert 'file:chunks/layout/loadmore.tpl'}
        </div>
    </section>
    <style>
        .review-content {
            position: relative;
            min-height: 365px;
        }
        .review-content:before {
            content:'';
            position: absolute;
            left: -36px;
            top: 288px;
            width: 36px;
            height: 26px;
            background: #ffffff;
            clip-path: polygon(100% 100%, 0% 0%, 100% 0%);
        }

        @media (max-width: 991.98px) {
            .review-content:before {
                display: none;
            }
        }
    </style>
{/block}