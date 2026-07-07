{set $reviews = lastReviews()}
<section class="reviews pt-4 pb-5">
    <div class="container-fluid">
        <div class="row">
            <div class="col-12 col-md-8 mx-auto text-center mb-5 px-4">
                <h2 class="header-title font-cofo text-uppercase mb-3">{$title ?: 'Отзывы'}</h2>
                <p class="header-description">{$description ?: 'Отзывы о наших приключениях'}</p>
                <div class="{if $reviews|length < 4} d-block d-md-none{/if}">
                    {insert 'file:chunks/layout/icon-scroll.tpl'}
                </div>
            </div>

            <div class="f-carousel f-carousel-center" id="reviews-carousel">
                <div class="f-carousel__viewport">
                    {foreach $reviews as $idx => $review}
                        {insert 'file:chunks/reviews/item.tpl'}
                    {/foreach}
                </div>
            </div>

            <div class="col-12 text-center">
                <a href="{urlName('reviews')}" class="d-inline-flex align-items-center gap-4">
                    <img loading="lazy" src="/assets/images/content/icons/reviews.svg" width="119" height="119" alt="">
                    <h5 class="text-start fw-bold text-gray mb-0 text-decoration-underline">Все отзывы <br>участников</h5>
                </a>
            </div>
        </div>
    </div>
</section>

{insert 'file:chunks/reviews/modal.tpl'}