<div class="f-carousel__slide" id="reviews-slide-{$review.id}">
    <div class="d-flex align-items-center gap-4 mb-3">
        {if $review.img}
            {set $img = $review.img|fromJSON}
            <img loading="lazy" class="rounded-circle" width="80" height="80" src="{$img.url|glide:'w=80&h=80&fit=crop&fm=webp'}" alt="{$img.alt ?: $review.name}">
        {else}
            <img loading="lazy" class="rounded-circle" width="80" height="80" src="/assets/images/content/avatar-fallback.png" alt="{$img.alt ?: $review.name}">
        {/if}

        <div class="reviews-name">
            <h4 class="h5 fw-bold m-0">{$review.name}</h4>
{*            {$review.publishedon|date:'Y-m-d H:m:s'}*}
            <small class="text-muted">{if $review.age}{$review.age} {$review.age|decl:'год|года|лет'}{/if}{if $review.work}, {$review.work}{/if}</small>
        </div>
    </div>
    {insert 'file:chunks/reviews/card.tpl'}
</div>