{set $site_url = $modx->config.site_url}

{set $eventList = []}
{set $index = 1}
{foreach $tours as $year => $months}
    {foreach $months as $month => $items}
        {foreach $items as $tour}

            {set $availability = 'https://schema.org/InStock'}
            {if $tour->places_left == 0}
                {set $availability = 'https://schema.org/SoldOut'}
            {elseif $tour->places_left <= 2}
                {set $availability = 'https://schema.org/LimitedAvailability'}
            {/if}

            {set $eventList[] = [
                '@type' => 'ListItem',
                'position' => $index++,
                'item' => [
                    '@type' => 'Event',
                    'name' => $tour.title,
                    'url' => $site_url ~ 'tours/' ~ $tour.alias,
                    'startDate' => $tour->start_date|date:'Y-m-d',
                    'endDate' => $tour->end_date|date:'Y-m-d',
                    'eventStatus' => 'https://schema.org/EventScheduled',
                    'eventAttendanceMode' => 'https://schema.org/OfflineEventAttendanceMode',
                    'location' => [
                        '@type' => 'Place',
                        'name' => $tour.country_name ~ ', ' ~ $tour.city_name,
                    ],
                    'organizer' => ['@id' => $site_url ~ '#organization'],
                    'offers' => [[
                        '@type' => 'Offer',
                        'price' => $tour->clear_price,
                        'priceCurrency' => $tour->currency,
                        'availability' => $availability,
                        'validFrom' => $tour->start_date|date:'Y-m-d',
                        'priceValidUntil' => $tour->start_date|date:'Y-m-d',
                        'url' => $site_url ~ 'tours/' ~ $tour.alias,
                    ]],
                ],
            ]}
        {/foreach}
    {/foreach}
{/foreach}

<script type="application/ld+json">
    {
      "@context": "https://schema.org",
      "@graph": [
        {
          "@type": "ItemList",
          "@id": "{$site_url}{$modx->resource->alias}#list",
          "name": "{$modx->resource->pagetitle}",
          "description": "{$modx->resource->description|notags}",
          "url": "{$site_url}{$modx->resource->uri}",
          "itemListElement": {$eventList|toJSON}
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