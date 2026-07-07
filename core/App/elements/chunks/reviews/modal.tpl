{foreach $reviews as $idx => $review}
    {if $review.content|length > 300}
        {set $img = $review.img|fromJSON}
        <div class="modal" id="modal-review-{$review.id}" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content rounded-4 p-4">
                    <button type="button" class="btn-close position-absolute top-0 end-0 p-3 text-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    <div class="d-flex align-items-center gap-4 mb-3">
                        <img loading="lazy" class="rounded-4" width="80" height="80" src="{$img.url|glide:'w=80&h=80&fit=crop&fm=webp'}" alt="{$img.alt ?: $data.name}">
                        <div class="reviews-name">
                            <h5 class="fw-bold m-0">{$review.name}</h5>
                            <small class="text-muted">{if $review.age}{$review.age} {$review.age|decl:'год|года|лет'}, {/if}{$review.work}</small>
                        </div>
                    </div>
                    {$review.content}
                    {if $review.gallery}
                        <div class="d-flex flex-wrap gap-2">
                            {foreach $review.gallery as $item}
                                <a href="{$item.url|glide:'f=webp'}" data-fancybox="tour" class="gallery-item">
                                    <img loading="lazy" class="rounded-4" src="{$item.url|glide:'w=200&h=200&fit=crop&fm=webp'}" width="200" height="200" alt="{$item.title}">
                                </a>
                            {/foreach}
                        </div>
                    {/if}
                </div>
            </div>
        </div>
    {/if}
{/foreach}