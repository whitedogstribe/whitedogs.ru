{set $site_url = $modx->config.site_url}

{* Лидеры — в employee Organization *}
{set $employeeList = []}
{set $memberList = []}
{set $index = 1}
{foreach $modx->resource->leaders as $item}
    {set $employeeList[] = [
    '@type' => 'Person',
    'name' => $item.name,
    'jobTitle' => $item.position,
    'url' => $site_url ~ 'team/' ~ $item.alias,
    ]}

    {set $img = $item.avatar|fromJSON}
    {set $memberList[] = [
    '@type' => 'ListItem',
    'position' => $index++,
    'item' => [
    '@type' => 'Person',
    'name' => $item.name,
    'jobTitle' => $item.position,
    'url' => $site_url ~ 'team/' ~ $item.alias,
    'image' => $img.url|glide:'w=400&h=400&fit=crop&fm=webp',
    'description' => $item.description|strip_tags|truncate:200:'',
    'worksFor' => ['@id' => $site_url ~ '#organization'],
    ],
    ]}
{/foreach}

{foreach $modx->resource->instructors as $idx => $item}
    {set $img = $item.avatar|fromJSON}
    {set $memberList[] = [
        '@type' => 'ListItem',
        'position' => $index++,
        'item' => [
        '@type' => 'Person',
        'name' => $item.name,
        'jobTitle' => $item.position,
        'url' => $site_url ~ 'team/' ~ $item.alias,
        'image' => $img.url|glide:'w=400&h=400&fit=crop&fm=webp',
        'description' => $item.description|strip_tags|truncate:200:'',
        'worksFor' => ['@id' => $site_url ~ '#organization'],
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
          "url": "{$site_url}",
          "description": "{$modx->resource->introtext}",
          "logo": {
            "@type": "ImageObject",
            "url": "{$site_url}images/contacts/logo.svg"
          },
          "foundingDate": "2018",
          "sameAs": [
            "{$modx->config.social_telegram}",
            "{$modx->config.social_vk}",
            "{$modx->config.social_instagram}",
            "{$modx->config.social_youtube}"
          ],
         "employee": {$employeeList|toJSON}
      },
      {
        "@type": "ItemList",
          "itemListElement": {$memberList|toJSON}
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