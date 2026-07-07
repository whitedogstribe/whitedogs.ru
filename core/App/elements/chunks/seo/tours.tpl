{set $site_url = $modx->config.site_url}

{set $allTours = model('Tour')->select('title', 'alias')->published()->get()}

{set $tourList = []}
{foreach $allTours as $idx => $tour}
    {set $tourList[] = [
        '@type' => 'ListItem',
        'position' => $idx + 1,
        'name' => $tour.title,
        'url' => $site_url ~ 'tours/' ~ $tour.alias,
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
          "url": "{$site_url}",
          "logo": "{$site_url}assets/images/logo.svg",
          "sameAs": [
                "{$modx->config.social_telegram}",
                "{$modx->config.social_vk}",
                "{$modx->config.social_instagram}",
                "{$modx->config.social_youtube}"
            ]
        },
        {
          "@type": "ItemList",
          "@id": "{$site_url}{$modx->resource->alias}#list",
          "name": "{$modx->resource->pagetitle}",
          "url": "{$site_url}{$modx->resource->uri}",
          "numberOfItems": {$allTours|count},
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
            "name": "{$modx->resource->pagetitle}",
            "item": "{$site_url}{$modx->resource->uri}"
        }]
    }]
}
</script>