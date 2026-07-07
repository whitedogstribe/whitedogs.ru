{foreach $reviews as $review}
    <div class="row mb-5">
        <div class="col-12 col-lg-3 text-center text-lg-start pb-4">
            {if $review.img}
                {set $img = $review.img|fromJSON}
                <img loading="lazy" class="img-fluid rounded-circle mb-3" src="{$img.url|glide:'w=260&h=260&fit=crop&fm=webp'}" alt="{$review.name}">
            {else}
                <img loading="lazy" class="img-fluid rounded-circle mb-3" src="{'/assets/images/content/avatar-fallback.png'|glide:'w=260&h=260&fit=crop&fm=webp'}" alt="{$review.name}">
            {/if}
            {if $review.name}
                <div class="d-flex flex-column mx-auto mx-lg-0" style="max-width: 260px">
                    <h5 class="fw-bold">{$review.name}</h5>
                    <p class="m-0">рассказывает как {($review.name|gender) == 'male' ? 'прошёл' : 'прошла'} <a href="{$review.tour_url}" class="fw-semibold text-success">{$review.tour_name}</a></p>
                    <div class="text-muted">{if $review.age}{$review.age} {$review.age|decl: 'год|года|лет'}{/if}{if $review.work}, {$review.work}{/if}</div>
                </div>
            {/if}
        </div>
        <div class="col-12 col-lg-9">
            <div class="review-content bg-white shadow-lg p-3 rounded-4">
                {$review.content}
                {if $review.gallery}
                    <div class="d-flex flex-wrap gap-2 mt-3">
                        {foreach $review.gallery as $idx => $item}
                            <a href="{$item.url|glide:'f=webp'}" data-fancybox="review-{$review.id}" class="gallery-item">
                                <img loading="lazy" class="rounded-3" src="{$item.url|glide:'w=120&h=120&fit=crop&fm=webp'}" width="120" height="120" alt="{$item.title}">
                            </a>
                        {/foreach}
                    </div>
                {/if}
                {if $review.ssyilka_na_yandeks}
                    <div class="mt-3">
                        <a href="{$review.ssyilka_na_yandeks}" target="_blank" rel="noopener" class="text-muted small">отзыв на Яндексе</a>
                    </div>
                {/if}
            </div>
        </div>
    </div>
{/foreach}