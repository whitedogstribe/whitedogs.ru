<section class="blog-section mt-5 py-5">
    <div class="container">
        <div class="row">
            <div class="col-12 col-xl-9">
                <div class="d-flex align-items-center gap-5 mb-3">
                    <h1 class="font-cofo h0 text-uppercase m-0">{$title ?: $modx->resource->pagetitle}</h1>
                    <input
                            type="text"
                            id="blogSearchInput"
                            class="form-control w-100 rounded-5 px-4 bg-gray-50"
                            placeholder="Поиск в блоге..."
                            autocomplete="off"
                    >
                </div>

                {if $modx->resource->longtitle}
                    <p class="fw-bold"><i>{$modx->resource->longtitle}</i></p>
                {/if}

                <div class="mb-5">
                    {$modx->resource->content}
                </div>

                <div id="pb-items">
                    {insert 'file:chunks/blogs/items.tpl'}
                </div>

                <div id="pagination" pb-pagination>
                    {$links}
                </div>
                <style>
                    body {
                        background-color: #fff;
                    }
                    .blog-post-big:before {
                        content:'';
                        position: absolute;
                        inset:0;
                        width: 100%;
                        height: 100%;
                        background: rgba(0,0,0, .3);
                        border-radius: var(--bs-border-radius-xl);
                    }
                    @media (max-width: 1199.98px) {
                        .blog-post-big h2 {
                            font-size: 24px;
                        }
                    }

                    @media (max-width: 767.98px) {
                        .blog-post-big h2 {
                            font-size: 18px;
                        }
                        .blog-post-big p {
                            font-size: 14px;
                        }
                    }
                </style>
            </div>
            <div class="col-3 d-none d-xl-flex flex-column gap-5">
                <form action="{$modx->resource->uri}" method="get" pb-filter pb-filter-change>
                    <h5 class="mb-3">Всё из блога ↓</h5>
                    {set $field = query('pb_fields')->find(273)}
                    {set $properties = $field->properties|fromJSON}
                    {set $categories = $properties['options']|fromJSON}
                    {foreach $categories as $category}
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" value="{$category.value}" name="categories[]" id="category-{$category.value}">
                            <label class="form-check-label" for="category-{$category.value}">
                                {$category.name}
                            </label>
                        </div>
                    {/foreach}
                </form>

                {insert 'file:chunks/blogs/popular.tpl'}
                {insert 'file:chunks/tours/recommend.tpl'}
            </div>
        </div>
    </div>
</section>