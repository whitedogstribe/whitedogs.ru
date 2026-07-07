<section class="shop-section mt-5 py-5">
    <div class="container">
        <div class="row">
            <div class="col-12 mb-4">
                {set $crumbs=[['title'=>'Аренда','url'=>'']]}
                {insert 'file:chunks/breadcrumbs.tpl'}
                <h1 class="font-cofo text-uppercase">{$modx->resource->longtitle ?: $modx->resource->pagetitle}</h1>
                {if $modx->resource->description}
                    <p>{$modx->resource->description}</p>
                {/if}
            </div>

            <div class="col-12 col-xl-9">
                <div class="d-flex gap-3 justify-content-end mb-4">
                    <a href="{$modx->resource->uri}" class="btn btn-white{$.get.type != 'cart' ? ' is-active': ''}">
                        <span>Список</span>
                        <i class="bi bi-list-task"></i>
                    </a>
                    <a href="{$modx->resource->uri}?type=cart" class="btn btn-white{$.get.type == 'cart' ? ' is-active': ''}">
                        <span>Карточки</span>
                        <i class="bi bi-grid-3x3"></i>
                    </a>
                </div>
                <div class="row row-cols-1 gy-4 mb-5{$.get.type == 'cart' ? ' row-cols-sm-2 row-cols-lg-3' : ''}" id="pb-items">
                    {insert 'file:chunks/shop/items.tpl'}
                </div>

                <div id="pagination" pb-pagination>
                    {$links}
                </div>
            </div>

            <div class="col-12 col-xl-3 d-flex flex-column gap-5 ps-xl-5">
                {insert 'file:chunks/shop/categories.tpl'}
                {insert 'file:chunks/blogs/equipment.tpl'}
                {insert 'file:chunks/tours/recommend.tpl'}
            </div>
        </div>
    </div>
    <style>
        .product {
            padding: 8px;
            border-radius: 8px;
        }
        .product.even {
            background: #F5F2F0;
        }
        .product:hover h6 {
            color: var(--color-orange);
        }
        .product-card {
            display: flex;
            flex-direction: column;
            border-radius: 20px;
            overflow: hidden;
            background: #fff;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.06);
            transition: box-shadow .3s ease, transform .3s ease;
            height: 100%;
        }
        .product-card:hover {
            box-shadow: 0 16px 32px rgba(0, 0, 0, 0.1);
            transform: translateY(-4px);
        }
        .product-card__link {
            display: block;
            text-decoration: none;
            color: inherit;
            flex: 1;
        }
        .product-card__img {
            aspect-ratio: 1/1;
            overflow: hidden;
            background: #f8fafc;
        }
        .product-card__img img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block;
            transition: transform .4s ease;
        }
        .product-card:hover .product-card__img img {
            transform: scale(1.07);
        }
        .product-card__body {
            padding: 18px 18px 6px;
        }
        .product-card__title {
            font-size: 16px;
            font-weight: 600;
            margin: 0 0 10px;
            line-height: 1.3;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        .product-card__price {
            font-size: 20px;
            font-weight: 800;
            color: var(--color-success) !important;
        }
        .product-card__price-period {
            font-size: 13px;
            font-weight: 400;
            color: #9ca3af;
        }
        .product-card__button {
            margin: 14px 18px 18px;
            padding: 10px 16px;
            border: 2px solid var(--color-success);
            border-radius: 999px;
            background: var(--color-success);
            color: #fff;
            font-weight: 700;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: .02em;
            cursor: pointer;
            transition: background .2s ease, color .2s ease;
        }
        .product-card__button:hover {
            background: #fff;
            color: var(--color-success);
        }
    </style>
</section>