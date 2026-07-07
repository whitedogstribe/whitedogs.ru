<section class="content-section overflow-hidden bg-light-gray py-5" id="about">
    <div class="container pb-md-5">
        <div class="row">
            <div class="col-12 col-lg-6 mx-auto position-relative py-5">
                {if $modx->resource->longtitle}
                    <h2 class="font-cofo text-uppercase">{$modx->resource->longtitle}</h2>
                {/if}
                {$modx->resource->description}
                {set $index = 1}
                {foreach $modx->resource->images as $idx => $image}
                    {if $idx > 0 && $idx < 4}
                        {if $idx == 3}
                            <a href="{$image.url|glide:'f=webp'}" data-fancybox="tour" class="content-image content-image-{$index++}">
                                <img loading="lazy" src="{$image.url|glide:'w=200&h=350&fit=crop&fm=webp'}" alt="{$image.title}">
                            </a>
                        {else}
                            <a href="{$image.url|glide:'f=webp'}" data-fancybox="tour" class="content-image content-image-{$index++}">
                                <img loading="lazy" src="{$image.url|glide:'w=200&h=135&fit=crop&fm=webp'}" alt="{$image.title}">
                            </a>
                        {/if}
                    {/if}
                {/foreach}
            </div>
        </div>
    </div>
    <div class="position-absolute overflow-hidden start-0 w-100 text-white" style="bottom:-2px">
        <svg height="auto" width="100%" data-icon="section-slope" viewBox="0 0 2202 240">
            <use href="#section-slope"></use>
        </svg>
    </div>
    <style>
        .content-image {
            position: absolute;
            transition: .3s;
            border-radius: 1rem;
            overflow: hidden;
        }
        .content-image-1 {
            top: 7rem;
            left: -24rem;
            transform: rotate(-12deg);
        }
        .content-image-2 {
            left: -16rem;
            bottom: 2rem;
            transform: rotate(4deg);
        }
        .content-image-3 {
            top: 9rem;
            right: -16rem;
            transform: rotate(6deg);
        }
    </style>
</section>