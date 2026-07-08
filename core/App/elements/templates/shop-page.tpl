{extends 'file:templates/base.tpl'}

{block 'schema'}
    {insert 'file:chunks/seo/product.tpl'}
{/block}

{block 'style'}
    <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/@fancyapps/ui@6.1/dist/carousel/carousel.thumbs.css"
    />
    <script defer src="https://cdn.jsdelivr.net/npm/@fancyapps/ui@6.1/dist/carousel/carousel.thumbs.umd.js"></script>
{/block}

{block 'content'}
    <section class="shop-content mt-5 py-5">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    {set $crumbs=[['title'=>'Аренда','url'=>'/shop'],['title'=>$modx->resource->pagetitle,'url'=>'']]}
                    {insert 'file:chunks/breadcrumbs.tpl'}
                    <h1 class="font-cofo text-uppercase mb-3 mb-xl-5">
                        {$modx->resource->pagetitle}
                    </h1>
                </div>

                <div class="col-12 col-xl-9">
                    <div class="pe-xl-5">
                        {if $modx->resource->rent && $modx->resource->description}
                            <p>{$modx->resource->description}</p>
                        {/if}

                        <div class="d-flex flex-wrap gap-3 mb-5{if $modx->resource->rent} align-items-center{/if}">
                            <div class="d-flex flex-column">
                                <div class="f-carousel" id="product-gallery">
                                    {foreach $modx->resource->gallery as $image}
                                        <div
                                                class="f-carousel__slide"
                                                data-fancybox="gallery"
                                                data-src="{$image->url|glide:'w=1920&h=1080&fit=crop&fm=webp'}"
                                                data-thumb-src="{$image.url|glide:'w=94&h=76&fit=crop&fm=webp'}"
                                        >
                                            <img
                                                    loading="lazy"
                                                    src="{$image->url|glide:'w=388&h=388&fit=crop&fm=webp'}"
                                                    width="388"
                                                    height="388"
                                                    class="img-fluid"
                                                    alt="{$modx->resource->pagetitle}"
                                            />
                                        </div>
                                    {/foreach}
                                </div>
                            </div>

                            <div class="product-info col d-flex flex-column ps-5 align-items-start">
                                {if $modx->resource->rent}
                                    <span class="mb-2">от <span class="fw-bold color-orange h4">${$modx->resource->price|number_format:0: '' : ' '}</span> / в день <sup>*от 6 дней</sup></span>
                                    <span>Залог: <span class="fw-bold">${($modx->resource->old_price ?: $modx->resource->deposit)|number_format:0: '' : ' '}</span></span>
                                    <span class="mb-3">Вес: <span class="fw-bold">{$modx->resource->weight|number_format:2: '.' : ' '} кг</span></span>
                                    <small>Цена аренды:</small>
                                    <div class="table-price-wrap rounded-3 overflow-hidden w-100 my-1">
                                        <table class="table table-bordered text-center fs-14 m-0">
                                            <thead>
                                            <tr>
                                                <th>1 <br>день</th>
                                                <th>2 <br>дня</th>
                                                <th>3 <br>дня</th>
                                                <th>4 <br>дня</th>
                                                <th>5 <br>дней</th>
                                                <th>от 6 <br>дней</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <tr>
                                                {foreach $modx->resource->rental_prices as $idx => $price}
                                                    <th>${($price)|number_format:0: '.' : ' '}</th>
                                                {/foreach}
                                                <th>${($modx->resource->price)|number_format:0: '' : ' '} / в день</th>
                                            </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <small>Цена зависит от количества дней аренды.</small>
                                    <small class="mb-3">Даты аренды заполняются при оформлении заказа.</small>
                                    <button class="add-to-cart-btn btn btn-warning btn-lg px-4 rounded-2" data-product-id="{$modx->resource->id}" data-text="Арендовать">Арендовать</button>
                                {else}
                                    {if $modx->resource->description}
                                        <p class="mb-3">{$modx->resource->description}</p>
                                    {/if}

                                    <span class="mb-2">Цена: <span class="fw-bold color-orange h4">${$modx->resource->price|number_format:0: '' : ' '}</span></span>
                                    <span class="mb-3">Вес: <span class="fw-bold">{$modx->resource->weight|number_format:2: '.' : ' '} кг</span></span>
                                    <button class="add-to-cart-btn btn btn-warning btn-lg px-4 rounded-2" data-product-id="{$modx->resource->id}" data-text="Купить">Купить</button>
                                {/if}

                            </div>
                        </div>

                        {$modx->resource->content}
                        <hr>
                    </div>
                    {insert 'file:chunks/shop/tours.tpl'}
                </div>

                <div class="col-12 col-xl-3 d-flex flex-column gap-5">
                    {insert 'file:chunks/shop/categories.tpl'}
                    {insert 'file:chunks/shop/similar.tpl'}
                    {insert 'file:chunks/blogs/equipment.tpl'}
                    {insert 'file:chunks/tours/recommend.tpl'}
                </div>
            </div>
        </div>
    </section>
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            Carousel(
                document.getElementById("product-gallery"),
                {
                    Thumbs: {
                        type: "classic"
                    },
                }, {
                    Arrows,
                    Thumbs,
                }
            ).init();
        })
    </script>
    <style>
        .product-info {
            padding-bottom: 92px;
        }
        .table-price-wrap .table {
            border: 1px solid #E8C8A8;
        }
        .table-price-wrap .table thead>*>* {
            background: #EDDDD1;
        }
        .table-price-wrap .table tbody>*>* {
            background: #F3EDE9;
        }
        @media (max-width:992px) {
            .product-info {
                padding: 0 !important;
            }
        }
    </style>
{/block}