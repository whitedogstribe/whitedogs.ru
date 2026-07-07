{set $site_url = $modx->config.site_url}
{set $articleList = []}
{foreach $posts as $idx => $post}
    {set $img = $post->img|fromJSON}
    {set $author = $post->team->name ? $post->team->name : $post->user->fullname}
    {set $articleList[] = [
        '@type' => 'BlogPosting',
        'headline' => $post->title,
        'url' => $site_url ~ 'blog/' ~ $post->alias,
        'datePublished' => $post->publishedon|date:'Y-m-d',
        'image' => $img.url|glide:'w=1200&h=700&fit=crop&fm=webp',
        'description' => $post->description|notags|truncate:200:'',
        'author' => [
            '@type' => 'Person',
            'name' => $author,
            'url' => $site_url ~ 'team/' ~ $post->team->alias,
        ],
        'publisher' => ['@id' => $site_url ~ '#organization'],
    ]}
{/foreach}

<script type="application/ld+json">
    {
      "@context": "https://schema.org",
      "@graph": [
        {
          "@type": "Blog",
          "@id": "{$site_url}blog#blog",
          "name": "{$modx->resource->pagetitle}",
          "description": "{$modx->resource->content|notags|truncate:200:''}",
          "url": "{$site_url}blog",
          "publisher": {
            "@id": "{$site_url}#organization"
          },
          "blogPost": {$articleList|toJSON}
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
          "item": "{$site_url}blog"
        }
      ]
    }
  ]
}
</script>