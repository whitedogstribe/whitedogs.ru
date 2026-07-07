{set $items = model('BlogPost')->equipment(5)->get()}
{if $items|length}
    <div>
        <h6 class="mb-3">Статьи о снаряжении</h6>
        <div class="d-flex flex-column gap-3">
            {foreach $items as $post}
                <a href="{$post->getUrl()}" class="post-popular d-flex bg-white rounded-3 shadow overflow-hidden">
                    {set $img = $post->img|fromJSON}
                    <img src="{$img.url|glide:'w=80&h=80&fit=crop&fm=webp'}" width="80" height="80" class="img-fluid" alt="">
                    <div class="d-flex flex-column w-100 p-2">
                        <h6><small class="fs-12 fw-semibold">{$post->title}</small></h6>
                        <div class="d-flex justify-content-between gap-2 mt-auto">
                            <small class="d-flex align-items-center gap-1 fs-12">
                                <img loading="lazy" width="13" height="13" src="/assets/images/content/icons/calendar.svg" alt="{$post->publishedAtRu()}">
                                {$post->publishedAtRu()}
                            </small>
                            <small class="d-flex align-items-center gap-1 fs-12">
                                <img loading="lazy" width="12" height="10" src="/assets/images/content/icons/eye.svg" alt="{$post->views} {$post->views|decl:'просмотр|просмотра|просмотров'}">
                                {$post->views}
                            </small>
                        </div>
                    </div>
                </a>
            {/foreach}
        </div>
        <style>
            .post-popular:hover {
                box-shadow:none !important;
            }
            .post-popular:hover h6{
                color: var(--color-success);
            }
        </style>
    </div>
{/if}