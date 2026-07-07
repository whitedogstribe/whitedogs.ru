<div class="d-none d-xl-block">
    <h6 class="mb-3">Категория</h6>
    <hr>
    <ul class="list-unstyled d-flex flex-column gap-2 fs-14">
        <li>
            <a href="/shop/" class="link-orange{$modx->resource->alias == 'shop' ? ' is-active': ''}{$.get.type == 'list' ? '?type=list': ''}">Всё cнаряжение</a>
        </li>
        {foreach $categories as $category}
            <li>
                <a class="link-orange{$modx->resource->alias == $category->alias ? ' is-active': ''}" href="/shop/categories/{$category->alias}{$.get.type == 'list' ? '?type=list': ''}">{$category->title}</a>
            </li>
        {/foreach}
    </ul>
</div>