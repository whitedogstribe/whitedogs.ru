{set $site_url = $modx->config.site_url}
{set $img = $modx->resource->avatar|fromJSON}

{set $tourList = []}
{foreach $modx->resource->tours as $idx => $tour}
    {set $tourList[] = [
        '@type' => 'ListItem',
        'position' => $idx + 1,
        'item' => [
            '@type' => 'TouristTrip',
            'name' => $tour.title,
            'url' => $site_url ~ 'tours/' ~ $tour.alias,
        ],
    ]}
{/foreach}

<script type="application/ld+json">
    {
      "@context": "https://schema.org",
      "@graph": [
        {
          "@type": "Person",
          "@id": "{$site_url}team/{$modx->resource->alias}#person",
          "name": "{$modx->resource->pagetitle}",
          "jobTitle": "{$modx->resource->position}",
          "description": "{$modx->resource->content|notags|truncate:300:''}",
          "image": {
            "@type": "ImageObject",
            "url": "{$site_url}{$img.url|glide:'w=800&h=800&zc=1'}",
            "width": 800,
            "height": 800
          },
         "url": "{$site_url}team/{$modx->resource->alias}",
         "worksFor": {
            "@id": "{$site_url}#organization"
         }
    },
    {
        "@type": "ItemList",
        "name": "Туры {$modx->resource->pagetitle}",
        "itemListElement": {$tourList|toJSON}
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
          "name": "Команда",
          "item": "{$site_url}team"
        },
        {
          "@type": "ListItem",
          "position": 3,
          "name": "{$modx->resource->pagetitle}",
          "item": "{$site_url}team/{$modx->resource->alias}"
        }
      ]
    }
  ]
}
</script>