{set $site_url = $modx->config.site_url}
{set $img = $modx->resource->seo_img|fromJSON}
{if $modx->resource->rent}
    {set $rentOffers = []}
    {foreach $modx->resource->rental_prices as $idx => $price}
        {set $dayNum = $idx + 1}
        {set $rentOffers[] = [
            '@type' => 'Offer',
            'url' => $site_url ~ 'shop/' ~ $modx->resource->alias,
            'price' => $price,
            'priceCurrency' => 'USD',
            'availability' => 'https://schema.org/InStock',
            'itemCondition' => 'https://schema.org/UsedCondition',
            'seller' => ['@id' => $site_url ~ '#organization'],
            'priceSpecification' => [
                '@type' => 'UnitPriceSpecification',
                'price' => $price,
                'priceCurrency' => 'USD',
                'unitCode' => 'DAY',
            ],
            'eligibleDuration' => [
                '@type' => 'QuantitativeValue',
                'minValue' => $dayNum,
                'maxValue' => $dayNum,
                'unitCode' => 'DAY',
            ],
        ]}
    {/foreach}

    {set $rentOffers[] = [
        '@type' => 'Offer',
        'url' => $site_url ~ 'shop/' ~ $modx->resource->alias,
        'price' => $modx->resource->price,
        'priceCurrency' => 'USD',
        'availability' => 'https://schema.org/InStock',
        'itemCondition' => 'https://schema.org/UsedCondition',
        'seller' => ['@id' => $site_url ~ '#organization'],
        'priceSpecification' => [
        '@type' => 'UnitPriceSpecification',
            'price' => $modx->resource->price,
            'priceCurrency' => 'USD',
            'unitCode' => 'DAY',
        ],
        'eligibleDuration' => [
            '@type' => 'QuantitativeValue',
            'minValue' => 6,
            'unitCode' => 'DAY',
        ],
    ]}

    {set $schema = [
        '@context' => 'https://schema.org',
        '@graph' => [
        [
            '@type' => 'Product',
            '@id' => $site_url ~ 'shop/' ~ $modx->resource->alias ~ '#product',
            'name' => $modx->resource->pagetitle,
            'description' => $modx->resource->content|notags|truncate:500:'',
            'image' => $img.url|glide:'w=1280&h=1280&fit=crop&fm=webp',
            'url' => $site_url ~ 'shop/' ~ $modx->resource->alias,
            'brand' => [
                '@type' => 'Brand',
                'name' => $modx->resource->brand ?: $modx->config.site_name,
            ],
            'weight' => [
                '@type' => 'QuantitativeValue',
                'value' => $modx->resource->width,
                'unitCode' => 'KGM',
            ],
            'offers' => $rentOffers,
            ],
            [
                '@type' => 'BreadcrumbList',
                'itemListElement' => [
                    ['@type' => 'ListItem', 'position' => 1, 'name' => 'Главная', 'item' => $site_url],
                    ['@type' => 'ListItem', 'position' => 2, 'name' => 'Снаряжение', 'item' => $site_url ~ 'shop'],
                    ['@type' => 'ListItem', 'position' => 3, 'name' => $modx->resource->pagetitle, 'item' => $site_url ~ 'shop/' ~ $modx->resource->alias]
                ],
            ],
        ]
    ]}
{else}
    {set $schema = [
        '@context' => 'https://schema.org',
        '@graph' => [
            [
                '@type' => 'Product',
                '@id' => $site_url ~ 'shop/' ~ $modx->resource->alias ~ '#product',
                'name' => $modx->resource->pagetitle,
                'description' => $modx->resource->description ?: $modx->resource->pagetitle|strip_tags,
                'image' => $img.url|glide:'w=1280&h=1280&fit=crop&fm=webp',
                'url' => $site_url ~ 'shop/' ~ $modx->resource->alias,
                'brand' => [
                    '@type' => 'Brand',
                    'name' => $modx->resource->brand ?: $modx->config.site_name,
                ],
                'weight' => [
                    '@type' => 'QuantitativeValue',
                    'value' => $modx->resource->weight,
                    'unitCode' => 'KGM',
                ],
                'offers' => [
                    '@type' => 'Offer',
                    'url' => $site_url ~ 'shop/' ~ $modx->resource->alias,
                    'price' => $modx->resource->price,
                    'priceCurrency' => 'USD',
                    'availability' => 'https://schema.org/InStock',
                    'itemCondition' => 'https://schema.org/NewCondition',
                    'seller' => ['@id' => $site_url ~ '#organization'],
                ],
            ],
            [
                '@type' => 'BreadcrumbList',
                'itemListElement' => [
                    ['@type' => 'ListItem', 'position' => 1, 'name' => 'Главная', 'item' => $site_url],
                    ['@type' => 'ListItem', 'position' => 2, 'name' => 'Снаряжение', 'item' => $site_url ~ 'shop'],
                    ['@type' => 'ListItem', 'position' => 3, 'name' => $modx->resource->pagetitle, 'item' => $site_url ~ 'shop/' ~ $modx->resource->alias],
                ],
            ],
        ]
    ]}
{/if}

<script type="application/ld+json">{$schema|toJSON}</script>