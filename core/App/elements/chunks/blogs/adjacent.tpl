{set $prev = $modx->resource->prev()}
{set $next = $modx->resource->next()}
{if $prev || $next}
<div class="blog-adjacent mt-5">
    <h2 class="font-cofo mb-4">Читайте также</h2>
    <div class="row g-4">
        {if $prev}
            {set $prev_img = $prev->img|fromJSON}
            <div class="col-12 col-md-6">
                <a href="{$prev->getUrl()}" class="blog-adjacent-card d-block rounded-4 overflow-hidden text-decoration-none bg-white shadow-sm h-100">
                    {if $prev_img.url}
                        <img loading="lazy" src="{$prev_img.url|glide:'w=640&h=360&fit=crop&fm=webp'}" class="img-fluid w-100" style="height:220px;object-fit:cover" alt="{$prev->title}">
                    {/if}
                    <div class="p-4">
                        <div class="text-uppercase text-muted small fw-semibold mb-2" style="letter-spacing:.08em">Предыдущая статья</div>
                        <h5 class="fw-bold text-dark mb-2">{$prev->title}</h5>
                        <div class="text-muted small">{$prev->publishedAtRu()}</div>
                    </div>
                </a>
            </div>
        {/if}
        {if $next}
            {set $next_img = $next->img|fromJSON}
            <div class="col-12 col-md-6">
                <a href="{$next->getUrl()}" class="blog-adjacent-card d-block rounded-4 overflow-hidden text-decoration-none bg-white shadow-sm h-100">
                    {if $next_img.url}
                        <img loading="lazy" src="{$next_img.url|glide:'w=640&h=360&fit=crop&fm=webp'}" class="img-fluid w-100" style="height:220px;object-fit:cover" alt="{$next->title}">
                    {/if}
                    <div class="p-4">
                        <div class="text-uppercase text-muted small fw-semibold mb-2" style="letter-spacing:.08em">Следующая статья</div>
                        <h5 class="fw-bold text-dark mb-2">{$next->title}</h5>
                        <div class="text-muted small">{$next->publishedAtRu()}</div>
                    </div>
                </a>
            </div>
        {/if}
    </div>
</div>
{/if}
