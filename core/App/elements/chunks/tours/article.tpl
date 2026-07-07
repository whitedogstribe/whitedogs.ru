<div class="d-flex gap-3 mb-3">
    <img loading="lazy" src="{$img.url|glide:'w=112&h=74&fit=crop&fm=webp'}" width="112" height="74" alt="{$title}">
    <div class="d-flex flex-column gap-1">
        <a href="{$url}" class="h5 fw-bold mb-0">{$title}</a>
        <small class="text-muted">{$date}</small>
        <small class="fw-semibold">{$price}</small>
    </div>
</div>