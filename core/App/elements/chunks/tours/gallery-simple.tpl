{if $modx->resource->images|length > 10}
<section class="gallery-section pt-4 pb-5 mb-5">
    <div class="container-fluid p-0">
        <div class="d-flex justify-content-center gap-1">
            <div class="d-flex flex-column gap-1">
                {foreach $modx->resource->images as $idx => $item}
                    {if $idx > 9 && $idx < 12}
                        <a href="{$item.url|glide:'f=webp'}" data-fancybox="tour" class="gallery-item">
                            <img loading="lazy" src="{$item.url|glide:'w=800&h=600&fit=crop&fm=webp'}" alt="{$item.title}">
                        </a>
                    {/if}
                {/foreach}
            </div>
            {foreach $modx->resource->images as $idx => $item}
                {if $idx > 11 && $idx < 14}
                    <a href="{$item.url|glide:'f=webp'}" data-fancybox="tour" class="gallery-item d-none {$idx == 3 ? 'd-lg-flex' : 'd-md-flex'}">
                        <img loading="lazy" src="{$item.url|glide:'w=800&h=1200&fit=crop&fm=webp'}" alt="{$item.title}">
                    </a>
                {/if}
            {/foreach}
            <div class="d-flex flex-column gap-1">
                {foreach $modx->resource->images as $idx => $item}
                    {if $idx > 13 && $idx < 16}
                        <a href="{$item.url|glide:'f=webp'}" data-fancybox="tour" class="gallery-item">
                            <img loading="lazy" src="{$item.url|glide:'w=800&h=600&fit=crop&fm=webp'}" alt="{$item.title}">
                        </a>
                    {/if}
                {/foreach}
            </div>
        </div>
    </div>
</section>
{/if}