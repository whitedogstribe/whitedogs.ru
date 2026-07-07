<section class="gallery-section pt-4 pb-3 md-3 pb-md-5 mb-md-5">
    <div class="container">
        <div class="row">
            <div class="col-12 col-md-8 mx-auto text-center mb-3 mb-md-5 px-4">
                <h2 class="header-title h1 font-cofo text-uppercase mb-3">{$modx->resource->gallery_subtitle ?: 'КАК ТАМ?'}</h2>
                {if $modx->resource->gallery_title}
                    <h3 class="header-subtitle h5 fw-normal">{$modx->resource->gallery_title}</h3>
                {/if}
                {if $modx->resource->gallery_desc}
                    <p class="header-description">{$modx->resource->gallery_desc}</p>
                {/if}
            </div>
        </div>
    </div>
    <div class="container-fluid p-0">
        <div class="d-flex justify-content-center gap-1">
            <div class="d-flex flex-column gap-1">
                {foreach $modx->resource->images as $idx => $item}
                    {if $idx > 3 && $idx < 6}
                        <a href="{$item.url|glide:'f=webp'}" data-fancybox="tour" class="gallery-item">
                            <img loading="lazy" src="{$item.url|glide:'w=800&h=600&fit=crop&fm=webp'}" alt="{$item.title}">
                        </a>
                    {/if}
                {/foreach}
            </div>
            {foreach $modx->resource->images as $idx => $item}
                {if $idx > 5 && $idx < 8}
                    <a href="{$item.url|glide:'f=webp'}" data-fancybox="tour" class="gallery-item d-none {$idx == 3 ? 'd-lg-flex' : 'd-md-flex'}">
                        <img loading="lazy" src="{$item.url|glide:'w=800&h=1200&fit=crop&fm=webp'}" alt="{$item.title}">
                    </a>
                {/if}
            {/foreach}
            <div class="d-flex flex-column gap-1">
                {foreach $modx->resource->images as $idx => $item}
                    {if $idx > 7 && $idx < 10}
                        <a href="{$item.url|glide:'f=webp'}" data-fancybox="tour" class="gallery-item">
                            <img loading="lazy" src="{$item.url|glide:'w=800&h=600&fit=crop&fm=webp'}" alt="{$item.title}">
                        </a>
                    {/if}
                {/foreach}
            </div>
        </div>
    </div>
    <style>
        .gallery-item {
            position: relative;
            overflow: hidden;
            cursor: pointer;
            transition: transform 0.3s ease;
        }
        .gallery-grid:hover .gallery-item {
            opacity: .75;
        }
        .gallery-grid .gallery-item:hover {
            opacity: 1 !important;
        }
        .gallery-item img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block;
        }
    </style>
</section>