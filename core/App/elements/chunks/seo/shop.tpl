{set $site_url = $modx->config.site_url}
{set $productList = []}
{foreach $products as $idx => $product}
    {set $img = $product->seo_img|fromJSON}

    {set $productList[] = [
        '@type' => 'ListItem',
        'position' => $idx + 1,
        'item' => [
            '@type' => 'Product',
            'name' => $product->title,
            'url' => $site_url ~ 'shop/' ~ $product->alias,
            'description' => $product->description|notags|truncate:200:'',
            'image' => $img.url|glide:'w=400&h=400&fit=crop&fm=webp',
            'brand' => [
                '@type' => 'Brand',
                'name' => $product->brand ?: $modx->config.site_name,
            ],
            'offers' => [
                '@type' => 'Offer',
                'url' => $site_url ~ 'shop/' ~ $product->alias,
                'price' => $product->price,
                'priceCurrency' => 'USD',
                'availability' => 'https://schema.org/InStock',
                'itemCondition' => 'https://schema.org/NewCondition',
                'seller' => ['@id' => $site_url ~ '#organization'],
                'priceSpecification' => $product->rent ? [
                    '@type' => 'UnitPriceSpecification',
                    'price' => $product->price,
                    'priceCurrency' => 'USD',
                    'unitCode' => 'DAY',
                    'unitText' => 'в день',
                ] : null,
            ],
        ],
    ]}
{/foreach}

<script type="application/ld+json">
    {
      "@context": "https://schema.org",
      "@graph": [
        {
          "@type": "ItemList",
          "@id": "{$site_url}shop#list",
          "name": "{$modx->resource->pagetitle}",
         "description": "{$modx->resource->description|notags}",
          "url": "{$site_url}shop",
          "itemListElement": {$productList|toJSON}
      },
    {
      "@type": "BreadcrumbList",
      "itemListElement": [
        {
          "@type": "ListItem",
          "position": 1,
          "name": "Главная",
          "item": "{$site_url}"
        },
        {
          "@type": "ListItem",
          "position": 2,
          "name": "{$modx->resource->pagetitle}",
          "item": "{$site_url}{$modx->resource->alias}"
        }
      ]
    }
  ]
}
</script>