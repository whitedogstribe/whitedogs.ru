<div class="d-flex flex-column align-items-start gap-2 mb-4">
    {if $img}
        <a href="{$modx->resource->uri}/{$data.alias}">
            <img loading="lazy"
                 class="img-fluid mb-2"
                 src="{$img.url|glide:'w=472&h=280&fit=crop&fm=webp'}"
                 width="472"
                 height="280"
                 alt="{$img.title|notags}">
        </a>
    {/if}
    <div class="d-flex gap-2">
        <span class="badge rounded-pill text-uppercase">{$data.day}</span>
        <small>{$modx->resource->start_date|addDays:$idx}</small>
    </div>
    <h4 class="h6 fw-semibold">{$data.title}</h4>
    <div class="content mb-3">
        <small>{($data.description ?: $data.content)|notags|truncate:300}</small>
        <div class="d-flex flex-wrap align-items-center gap-2 mt-3">
            {if $data.transfer}
                <div class="d-flex align-items-center gap-1">
                    <img loading="lazy" src="/assets/images/content/icons/day-transfer.svg" alt="{$data.transfer}">
                    <small class="fs-12">{$data.transfer} км.</small>
                </div>
            {/if}
            {if $data.crossing}
                <div class="d-flex align-items-center gap-1">
                    <img loading="lazy" src="/assets/images/content/icons/day-hike.svg" alt="{$data.crossing}">
                    <small class="fs-12">{$data.crossing} км.</small>
                </div>
            {/if}
            {if $data.up}
                <div class="d-flex align-items-center gap-1">
                    <img loading="lazy" src="/assets/images/content/icons/day-up.svg" alt="{$data.up}">
                    <small class="fs-12">{$data.up} м.</small>
                </div>
            {/if}
            {if $data.down}
                <div class="d-flex align-items-center gap-1">
                    <img loading="lazy" src="/assets/images/content/icons/day-down.svg" alt="{$data.down}">
                    <small class="fs-12">{$data.down} м.</small>
                </div>
            {/if}
        </div>
    </div>
    <div>
        <a href="{$modx->resource->uri}/{$data.alias}" class="btn btn-outline-dark rounded-4 px-3 btn-sm">Подробнее</a>
    </div>
    <div class="d-flex justify-content-between gap-2 d-md-none w-100">
        {if $idx}
            <button type="button" class="btn btn-link d-flex text-black text-decoration-none align-items-center carousel-prev me-auto"><i class="bi bi-arrow-left-circle-fill"></i> День {$idx}</button>
        {/if}
        {if $idx < ($modx->resource->plan|length - 1)}
            <button type="button" class="btn btn-link d-flex text-black text-decoration-none align-items-center carousel-next ms-auto">День {$idx + 2} <i class="bi bi-arrow-right-circle-fill"></i></button>
        {/if}
    </div>
</div>