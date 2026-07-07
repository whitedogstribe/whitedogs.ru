<div class="product d-flex gap-3 mb-3">
    <img loading="lazy" src="{$img.url|glide:'w=112&h=74&fit=crop&fm=webp'}" width="112" height="74" alt="{$title}">
    <div class="d-flex flex-column align-items-start gap-1">
        <a href="{$url}" class="h6 fw-bold mb-0">{$title}</a>
        <small class="text-muted fw-bold">{$price}</small>
        <button type="button" data-product-id="{$id}" class="add-to-cart-btn btn btn-orange btn-sm rounded-4 px-3 mt-auto" data-text="{$rent ? 'Арендовать' : 'Купить'}">{$rent ? 'Арендовать' : 'Купить'}</button>
    </div>
</div>