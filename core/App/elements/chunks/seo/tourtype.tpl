{set $site_url = $modx->config.site_url}
{set $tourList = []}
{foreach $tours as $idx => $tour}
    {set $tourList[] = [
        '@type' => 'ListItem',
        'position' => $idx + 1,
        'item' => [
        '@type' => 'TouristTrip',
        'name' => $tour->title,
        'url' => $site_url ~ $tour->alias,
        'touristType' => $.pb.tour_level[$tour->level],
        'offers' => [
            '@type' => 'Offer',
            'price' => $tour->clear_price,
            'priceCurrency' => $tour->currency,
            'availability' => $tour->is_sold_out
                ? 'https://schema.org/SoldOut'
                : 'https://schema.org/InStock',
            ],
        ],
    ]}
{/foreach}

{set $schema = [
    '@context' => 'https://schema.org',
        '@graph' => [
            [
                '@type' => 'ItemList',
                '@id' => $site_url ~ 'tourtype/' ~ $modx->resource->alias ~ '#list',
                'name' => $modx->resource->pagetitle,
                'description' => $modx->resource->description ?: $modx->resource->introtext|strip_tags,
                'url' => $site_url ~ 'tourtype/' ~ $modx->resource->alias,
                'numberOfItems' => $tours|count,
                'itemListElement' => $tourList,
            ],
        [
            '@type' => 'BreadcrumbList',
            'itemListElement' => [
                ['@type' => 'ListItem', 'position' => 1, 'name' => 'Главная', 'item' => $site_url],
                ['@type' => 'ListItem', 'position' => 2, 'name' => $modx->resource->pagetitle, 'item' => $site_url ~ 'tourtype/' ~ $modx->resource->alias],
            ],
        ],
    ],
]}

<script type="application/ld+json">{$schema|toJSON}</script>