<div class="row">
    {if $posts}
    {foreach $posts as $idx => $post}
        {if $idx}
            <div class="col-12 col-sm-6 col-lg-4 mb-4">
                {insert 'file:chunks/blogs/item.tpl'}
            </div>
        {else}
            <div class="col-12 mb-3">
                {set $img = $post->img|fromJSON}
                <article class="d-none d-md-flex blog-post-big position-relative">
                    <img loading="lazy"
                         src="{$img.url|glide:'w=966&h=559&fit=crop&fm=webp'}"
                         width="966"
                         height="559"
                         class="img-fluid rounded-4"
                         alt="{$post->title}">
                    <div class="d-flex flex-column position-absolute inset-0 p-4 text-white">
                        <div class="logo">
                            <img loading="lazy" width="36" height="30" src="/assets/images/logo-white.svg" alt="{$post->title}">
                        </div>
                        <div class="blog-content text-center position-absolute top-50 start-50 translate-middle p-5 p-lg-0">
                            <h2 class="font-cofo mb-3">
                                <a href="{$post->getUrl()}" class="text-white">{$post->title}</a>
                            </h2>
                            <p>{$post->description}</p>
                        </div>
                        <div class="mt-auto d-flex justify-content-between gap-2">
                            <small class="d-flex align-items-center gap-1">
                                <img loading="lazy" width="13" height="13" src="/assets/images/content/icons/calendar-white.svg" alt="{$post->publishedAtRu()}">
                                {$post->publishedAtRu()}
                            </small>
                            {paste 'author'}
                            <small class="d-flex align-items-center gap-1">
                                <img loading="lazy" width="14" height="12" src="/assets/images/content/icons/eye-white.svg" alt="{$post->views} {$post->views|decl:'просмотр|просмотра|просмотров'}">
                                {$post->views}
                            </small>
                        </div>
                    </div>
                </article>
                <div class="d-block d-md-none">
                    {insert 'file:chunks/blogs/item.tpl'}
                </div>
            </div>
        {/if}
    {/foreach}
    {else}
        <div class="col-12">
            Ничего не найдено
        </div>
    {/if}
    <style>
        @media (max-width: 992px) {
            .blog-post-big .blog-content {
                top: 0 !important;
                left: 0 !important;
                transform: none !important;
            }
        }
    </style>
</div>