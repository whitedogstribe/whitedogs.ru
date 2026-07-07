{set $site_url = $modx->config.site_url}
{set $reviewList = []}
{foreach $reviews as $idx => $review}
    {set $reviewList[] = [
        '@type' => 'ListItem',
        'position' => $idx + 1,
        'item' => [
            '@type' => 'Review',
            'author' => [
                '@type' => 'Person',
                'name' => $review.name,
            ],
        'reviewBody' => $review.content|strip_tags|truncate:300:'',
        'itemReviewed' => [
            '@type' => 'TouristTrip',
            'name' => $review.tour_name,
            'url' => $site_url ~ $review.tour_url,
        ],
    ],
]}
{/foreach}

<script type="application/ld+json">
    {
      "@context": "https://schema.org",
      "@graph": [
        {
              "@type": "Organization",
              "@id": "{$site_url}#organization",
              "name": "{$modx->config.site_name}",
              "url": "{$site_url}"
        },
    {
      "@type": "ItemList",
      "@id": "{$site_url}reviews#list",
      "name": "{$modx->resource->pagetitle}",
      "url": "{$site_url}reviews",
      "itemListElement": {$reviewList|toJSON}
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
            "item": "{$site_url}{$modx->resource->uri}"
        }]
    }]
  }]
}
</script>