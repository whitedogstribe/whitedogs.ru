{if $product->seo_img}{set $img = $product->seo_img|fromJSON}{else}{set $img = $product->image}{/if}
{set $type = $type ?: $.get.type}
{if $type != 'cart'}
    <div class="col-12">
        <div class="product product-list d-flex align-items-start gap-3 {($idx % 2) == 0 ? 'odd' : 'even'}">
            <a href="shop/{$product->alias}" class="bg-white p-3 rounded-2">
                <img loading="lazy"
                     class="img-fluid"
                     width="48"
                     height="48"
                     src="{$img.url|glide:'w=48&h=48&fit=crop&fm=webp'}"
                     alt="{$product->title}">
            </a>
            <div class="col d-flex flex-column gap-2">
                <a href="shop/{$product->alias}">
                    <h6 class="fw-bold mb-0">{$product->title}</h6>
                </a>
                <p class="d-none d-sm-block m-0">{$product->description|ellipsis:110}</p>
                <div class="d-flex align-items-center gap-3">
                    <span class="fw-bold" style="color:var(--color-success)">
                        {if $product->rent}
                            от {$product->price|number_format:0:'':' '}$ / в день
                        {else}
                            {$product->price|number_format:0:'':' '}$
                        {/if}
                    </span>
                    <button type="button" data-product-id="{$product->id}" class="add-to-cart-btn btn btn-transparent btn-outline-dark btn-sm rounded-4 px-3 mt-auto" data-text="{$product->rent ? 'Арендовать' : 'Купить'}">{$product->rent ? 'Арендовать' : 'Купить'}</button>
                </div>
            </div>
        </div>
    </div>
    <style>
       @media (max-width: 576px) {
           .product-list span {
               font-size: 12px;
           }
       }
    </style>
{else}
<div class="col">
<div class="product-card">
    <a href="shop/{$product->alias}" class="product-card__link">
        <div class="product-card__img">
            <img loading="lazy"
                 width="400"
                 height="400"
                 src="{$img.url|glide:'w=400&h=400&fit=crop&fm=webp'}"
                 alt="{$product->title}">
        </div>
        <div class="product-card__body">
            <h2 class="product-card__title">{$product->title}</h2>
            <div class="product-card__price">
                {if $product->rent}
                    {$product->price|number_format:0:'':' '}$<span class="product-card__price-period">/сутки</span>
                {else}
                    {$product->price|number_format:0:'':' '}$
                {/if}
            </div>
        </div>
    </a>
    <button type="button" data-product-id="{$product->id}" class="add-to-cart-btn product-card__button" data-text="{$product->rent ? 'В аренду' : 'Купить'}">{$product->rent ? 'В аренду' : 'Купить'}</button>
</div>
</div>
{/if}