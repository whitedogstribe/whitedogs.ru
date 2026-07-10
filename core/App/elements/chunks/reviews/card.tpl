<div class="reviews-card p-4 mb-3">
    {$review.content|ellipsis: '300'}
    {if $review.gallery}
        <div class="d-flex flex-wrap gap-2">
            {foreach $review.gallery as $idx => $item}
                {if $idx < 4}
                    <a href="/{$item.url}" data-fancybox="reviews" class="gallery-item">
                        <img loading="lazy" class="rounded-4" src="{$item.url|glide:'w=70&h=70&fit=crop&fm=webp'}" width="70" height="70" alt="{$item.title}">
                    </a>
                {/if}
            {/foreach}
        </div>
    {/if}
    {if $review.content|length > 300}
        <button type="button" class="btn btn-review mt-3 gap-0" data-bs-toggle="modal" data-bs-target="#modal-review-{$review.id}">
            <i class="bi bi-chevron-right"></i> Читать весь отзыв
        </button>
    {/if}
</div>
{set $tour = $review.tour}
<p class="reviews-link">{if $modx->resource->template_name == 'base'}Отзыв на <a class="btn-link" href="tours/{$tour->alias}">{$tour->menutitle ?: $tour->title}</a>{/if}{if $review.ssyilka_na_yandeks} взят с <a class="btn-link" href="{$review.ssyilka_na_yandeks}" target="_blank">Яндекс Отзывов</a>{/if}</p>