{set $img = $modx->resource->img|fromJSON}
{set $author = $modx->resource->team->name ? $modx->resource->team->name : $modx->resource->user->fullname}
{set $teamUrl = ''}
{if $modx->resource->team->name}
    {set $teamUrl = $site_url ~ 'team/' ~ $modx->resource->team->alias}
{/if}
<script type="application/ld+json">
    {
      "@context": "https://schema.org",
      "@graph": [
        {
          "@type": "BlogPosting",
          "@id": "{$site_url}blog/{$modx->resource->alias}#article",
          "headline": "{$modx->resource->pagetitle}",
          "description": "{$modx->resource->description|notags|truncate:200:''}",
          "url": "{$site_url}{$modx->resource->alias}",
          "datePublished": "{$modx->resource->publishedon|date:'Y-m-d'}",
          "dateModified": "{$modx->resource->updated_at|date:'Y-m-d'}",
          "image": {
            "@type": "ImageObject",
            "url": "{$site_url}{$img.url|glide:'w=1200&h=680&fit=crop&fm=webp'}",
            "width": 1200,
            "height": 680
          },
          {if $teamUrl}
          "author": {
            "@type": "Person",
            "@id": "{$teamUrl}#person",
            "name": "{$author}",
            "url": "{$teamUrl}"
          },
          {/if}
          "publisher": {
            "@id": "{$site_url}#organization"
          },
          "mainEntityOfPage": {
            "@type": "WebPage",
            "@id": "{$site_url}blog/{$modx->resource->alias}"
          },
          "inLanguage": "ru",
          "wordCount": {$modx->resource->content|notags|split:' '|count}
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
          "name": "Блог",
          "item": "{$site_url}blog"
        },
        {
          "@type": "ListItem",
          "position": 3,
          "name": "{$modx->resource->pagetitle}",
          "item": "{$site_url}blog/{$modx->resource->alias}"
        }
      ]
    }
  ]
}
</script>