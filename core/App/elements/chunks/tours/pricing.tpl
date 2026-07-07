<section class="pricing-section pt-4" id="price">
    <div class="container">
        
        <div class="row mb-5">
            <div class="col-12 col-lg-7 mb-5 mb-lg-0">
                {if $modx->resource->price_title}
                    <div class="row mb-5">
                        <h2 class="header-title h1 font-cofo text-left">{$modx->resource->price_title}</h2>
                    </div>
                {/if}
            </div>
            <div class="col-12 col-lg-5">
                
                {if $modx->resource->discount}
                    <div class="d-flex flex-wrap gap-3 align-items-center justify-content-center justify-content-sm-start text-white bg-black mx-auto py-2 px-3 rounded-3">
                        <div class="d-flex flex-column">
                            <span class="h2 text-danger text-decoration-line-through m-0 tour-old-price">{$modx->resource->old_price}</span>
                            <span class="h3 fw-bold m-0">-<span class="tour-discount">{$modx->resource->discount}</span>%</span>
                        </div>
                        <span class="font-cofo price">{$modx->resource->price}</span>
                    </div>
                {else}
                    <div class="mb-1">
                        <span class="h1 font-cofo price">{$modx->resource->price}</span>
                    </div>
                {/if}
                
                {if $modx->resource->dates|length > 1}
                    {insert 'file:chunks/layout/select-dates-price.tpl'}
                {else}
                    <p class="header-description d-block small fw-bold mb-1">{$modx->resource->date_range}</p>
                {/if}

                {set $price = $modx->resource->price ?: 0}
                {set $amount = ($price|replace:'руб':''|replace:'$':''|replace:' ':'') + 0}
                {set $currency = $price|trim|substr:-1}
                {set $prepay = $amount * 0.2}
               
               <p class="small">
                   Для брони места нужна предоплата — {$prepay|round} {$currency}. Остаток вносится наличными при встрече группы
               </p>
            </div>
        </div>

        <div class="row">
            <div class="col-12 col-lg-6 mb-5 mb-lg-0">
                <div class="included-section mb-5 included">
                    <div class="list-header">
                        <div class="list-icon">
                            <svg fill="#28a745" viewBox="0 0 24 24">
                                <path d="M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41L9 16.17z"/>
                            </svg>
                        </div>
                        <h5 class="fw-bold mb-0">Включено</h5>
                    </div>

                    {$modx->resource->included|replace:'href="':('href="' ~ $modx->resource->uri ~ '/')}
                </div>
            </div>

            <div class="col-12 col-lg-6">
                <div class="excluded-section mb-5 excluded">
                    <div class="list-header">
                        <div class="list-icon">
                            <svg fill="#dc3545" viewBox="0 0 24 24">
                                <path d="M19 6.41L17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12 19 6.41z"/>
                            </svg>
                        </div>
                        <h5 class="fw-bold mb-0">Не включено</h5>
                    </div>
                    {$modx->resource->excluded|replace:'href="':('href="/' ~ $modx->resource->uri ~ '/')}
                </div>
            </div>
        </div>
    </div>
    <style>
        .list-header {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 16px;
        }
        .list-icon {
            width: 30px;
            height: 30px;
            padding: 5px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }
        .pricing-section a {
            color: var(--color-success);
        }
        .included .list-icon {
            background: #d4edda;
        }

        .excluded .list-icon {
            background: #f8d7da;
        }

        .list-icon svg {
            width: 24px;
            height: 24px;
        }
        .pricing-section ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .pricing-section ul li {
            position: relative;
            font-size: 14px;
            font-weight: 500;
            line-height: 20px;
            padding-left: 28px;
        }
        .pricing-section ul li + li {
            margin-top: 8px;
        }

        .pricing-section li::before {
            content: '';
            display: block;
            width: 16px;
            height: 16px;
            position: absolute;
            left: 5px;
            top: 3px;
            background-repeat: no-repeat;
        }

        .included ul li::before {
            background-image: url('data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxZW0iIGhlaWdodD0iMWVtIiB2aWV3Qm94PSIwIDAgMTYgMTYiPjxwYXRoIGZpbGw9ImN1cnJlbnRDb2xvciIgZD0iTTEwLjk3IDQuOTdhLjc1Ljc1IDAgMCAxIDEuMDcgMS4wNWwtMy45OSA0Ljk5YS43NS43NSAwIDAgMS0xLjA4LjAyTDQuMzI0IDguMzg0YS43NS43NSAwIDEgMSAxLjA2LTEuMDZsMi4wOTQgMi4wOTNsMy40NzMtNC40MjV6Ii8+PC9zdmc+');
        }

        .excluded ul li::before {
            background-image: url('data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxZW0iIGhlaWdodD0iMWVtIiB2aWV3Qm94PSIwIDAgMTYgMTYiPjxwYXRoIGZpbGw9ImN1cnJlbnRDb2xvciIgZD0iTTQuNjQ2IDQuNjQ2YS41LjUgMCAwIDEgLjcwOCAwTDggNy4yOTNsMi42NDYtMi42NDdhLjUuNSAwIDAgMSAuNzA4LjcwOEw4LjcwNyA4bDIuNjQ3IDIuNjQ2YS41LjUgMCAwIDEtLjcwOC43MDhMOCA4LjcwN2wtMi42NDYgMi42NDdhLjUuNSAwIDAgMS0uNzA4LS43MDhMNy4yOTMgOEw0LjY0NiA1LjM1NGEuNS41IDAgMCAxIDAtLjcwOCIvPjwvc3ZnPg==');
        }
    </style>
</section>