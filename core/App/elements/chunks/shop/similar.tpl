<div class="shop-similar">
    <h6 class="mb-3">Из этой же категории</h6>
    {set $similarItems = model('Product')->where('category_id', $modx->resource->category_id)->with('image')->published()->limit(8)->get()}
    {foreach $similarItems as $item}
        <a href="/shop/{$item->alias}" class="d-flex gap-2 mb-3 bg-white rounded-3 shadow p-2">
            {if $item->seo_img}{set $img = $item->seo_img|fromJSON}{else}{set $img = $item->image}{/if}
            <img src="{$img.url|glide:'w=60&h=60&fit=contain&fm=webp'}" width="60" height="60" class="img-fluid" alt="{$item->title}">
            <div class="d-flex flex-column">
                <h6 class="fs-12">{$item->title}</h6>
                <div class="d-flex justify-content-between gap-2">
                    <small class="fs-10 text-muted">
                        {if $item->rent}
                            Аренда: от <span class="fw-bold">{$item->price|number_format:0:'':' '}$</span> / в день
                        {else}
                            Цена: <span class="fw-bold">{$item->price|number_format:0:'':' '}$</span>
                        {/if}
                    </small>
                    {if $item->rent && $item->deposit}
                        <small class="fs-10">
                            Залог: <span class="fw-bold">${$item->deposit|number_format:0:'':' '}</span>
                        </small>
                    {/if}
                </div>
            </div>
        </a>
    {/foreach}
    <style>
        .shop-similar a:hover h6 {
            color: var(--color-orange);
        }
    </style>
</div>