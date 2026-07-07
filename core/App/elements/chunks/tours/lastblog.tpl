{if $modx->resource->posts}
    {set $blogs = model('BlogPost')
    ->with(['team', 'user'])
    ->published()
    ->whereIn('id', $modx->resource->posts)
    ->ordered()
    ->get()}
<section class="lastblog-section pt-4 pb-3 pb-md-5">
    <div class="container-fluid">
        <div class="row">
            <div class="col-12 col-md-8 mx-auto text-center mb-5 px-4">
                <h2 class="header-title h1 font-cofo text-uppercase mb-3">Последнее из блога</h2>
                <p class="header-description">Отчёты и статьи на тему «{$modx->resource->menutitle ?: $modx->resource->pagetitle}»</p>
                {if $blogs|length > 3}
                    {insert 'file:chunks/layout/icon-scroll.tpl'}
                {/if}
            </div>
        </div>

        <div class="f-carousel f-carousel-center" id="blog-carousel">
            <div class="f-carousel__viewport pb-5">
                {foreach $blogs as $post}
                    <div class="f-carousel__slide">
                        {insert 'file:chunks/blogs/item.tpl'}
                    </div>
                {/foreach}
            </div>
        </div>

        <div class="row">
            <div class="col-12 text-center mt-5">
                <a href="{urlName('blog')}" class="d-inline-flex align-items-center gap-4">
                    <img loading="lazy" src="/assets/images/content/icons/blog-icon.svg" width="123" height="123" alt="Посмотреть все статьи">
                    <h5 class="text-start fw-bold text-gray mb-0 text-decoration-underline">Посмотреть<br>все статьи</h5>
                </a>
            </div>
        </div>
    </div>
    <style>
        #blog-carousel {
            --f-carousel-slide-width: 304px;
            --f-carousel-gap: 30px;
        }
    </style>
</section>
{/if}