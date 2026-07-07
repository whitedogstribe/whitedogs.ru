{set $posts = model('BlogPost')
    ->with(['team', 'user'])
    ->where('author_id', $modx->resource->id)
    ->published()
    ->ordered()}

{set $count = $posts->count()}
{set $posts = $posts->limit(8)->get()}

{if $posts && $count}
<section class="leads-posts pb-5">
    <div class="container">
        <div class="row">
            <h3 class="fw-bold mb-3">Пишет в блог ({$count})</h3>
        </div>

        <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 row-cols-xl-4 g-3 mb-5">
            {foreach $posts as $post}
                <div class="col-auto">
                    {insert 'file:chunks/blogs/item.tpl'}
                </div>
            {/foreach}
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
</section>
{/if}