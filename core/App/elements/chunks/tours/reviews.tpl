{if $reviews}
    <section class="reviews-section pt-4 pb-3 pb-md-5" id="reviews">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12 col-md-8 mx-auto text-center mb-5 px-4">
                    <h2 class="header-title h1 font-cofo text-uppercase mt-0 mb-4">{$modx->resource->reviews_title ?: 'ОТЗЫВЫ'}</h2>
                    {if $modx->resource->reviews_subtitle}
                        <h3 class="header-subtitle h5 fw-normal">{$modx->resource->reviews_subtitle}</h3>
                    {/if}
                    {if $modx->resource->reviews_desc}
                        <p class="header-description desc-short mx-auto">{$modx->resource->reviews_desc}</p>
                    {/if}
                    {if $modx->user->id != 1}
                        <iframe class="mx-auto mb-12 mt-4" height="50" src="https://yandex.ru/sprav/widget/rating-badge/123003633862?type=rating" title="Рейтинг на Яндекс Отзывы" width="150"></iframe>
                    {/if}
                    <div class="d-block{if $reviews|length < 4} d-md-none{/if}">
                        {insert 'file:chunks/layout/icon-scroll.tpl'}
                    </div>
                </div>
            </div>

            <div class="f-carousel f-carousel-default" id="reviews-carousel">
                <div class="f-carousel__viewport">
                    {foreach $reviews as $idx => $review}
                        {insert 'file:chunks/reviews/item.tpl'}
                    {/foreach}
                </div>
            </div>

            <div class="row">
                <div class="col-auto mx-auto text-center py-4">
                    <button type="button"
                            class="btn btn-danger text-uppercase px-5 py-3 rounded-5"
                            data-bs-toggle="modal"
                            data-bs-target="#modal-signup"
                            data-id="{$modx->resource->id}"
                            data-title="{$modx->resource->title}"
                            data-url="{$modx->config.site_url}{$modx->resource->uri}"
                            data-price="{$modx->resource->price}"
                    >
                        <span class="px-4 fw-bold">Записаться в поход!</span>
                    </button>
                </div>
            </div>
        </div>
    </section>
    {insert 'file:chunks/reviews/modal.tpl'}
{/if}