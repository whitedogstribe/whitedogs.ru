{set $img = $post->img|fromJSON}
{set $url = $post->getUrl()}
<article class="card blog-post gap-3 p-3">
    <a href="{$url}">
        <img loading="lazy"
             src="{$img.url|glide:'w=272&h=194&fit=crop&fm=webp'}"
             width="272"
             height="194"
             class="img-fluid"
             alt="{$post->title}">
    </a>

    <h3 class="h6 fw-semibold">
        <a href="{$url}" class="btn-hidelink">{$post->title}</a>
    </h3>
    {if $modx->resource->template_name != 'tour-page'}
        <small class="mt-auto">{$post->getExcerpt()}</small>
    {/if}
    <div class="d-flex flex-column gap-2 mt-auto">
        {block 'author'}
            <small>Автор:
                {if $post->team->name}
                    <a href="{route('team.show', ['alias' => $post->team->alias])}" class="fw-semibold text-success">{$post->team->name}</a>
                {else}
                    {$post->user->fullname}
                {/if}
            </small>
        {/block}
        <div class="d-flex align-items-center justify-content-between">
            <small class="d-flex align-items-center gap-1">
                <i class="bi bi-calendar3" style="font-size:13px"></i>
                {$post->publishedAtRu()}
            </small>
            <small class="d-flex align-items-center gap-1">
                <i class="bi bi-eye" style="font-size:13px"></i>
                {$post->views}
            </small>
        </div>
    </div>
    <div>
        <a href="{$url}" class="btn btn-outline-secondary rounded-5 px-3 text-uppercase d-inline-flex align-items-center gap-1">
            <small>Читать статью</small>
            <i class="bi bi-arrow-right-short"></i>
        </a>
    </div>
</article>