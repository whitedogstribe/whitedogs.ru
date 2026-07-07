{set $site_url = $modx->config.site_url}
<script type="application/ld+json">
    {
      "@context": "https://schema.org",
      "@graph": [
        {
          "@type": "Organization",
          "@id": "{$site_url}#organization",
          "name": "{$modx->config.site_name}",
          "url": "{$site_url}",
          "logo": {
            "@type": "ImageObject",
            "url": "{$site_url}assets/images/logo.svg"
          },
          "foundingDate": "2018",
          "description": "{$modx->config.company_desc}",
          "contactPoint": [
        {
          "@type": "ContactPoint",
          "contactType": "customer support",
          "url": "{$modx->config.telegram|replace:'@':'https://t.me/'}",
          "contactOption": "TollFree"
        },
        {
          "@type": "ContactPoint",
          "contactType": "customer support",
          "telephone": "{$modx->config.whatsapp|phone}",
          "contactOption": "TollFree"
        },
        {
          "@type": "ContactPoint",
          "contactType": "sales",
          "url": "{$modx->config.business_telegram|replace:'@':'https://t.me/'}",
          "description": "Сотрудничество"
        }
      ],
      "sameAs": [
            "{$modx->config.social_telegram}",
            "{$modx->config.social_vk}",
            "{$modx->config.social_instagram}",
            "{$modx->config.social_youtube}"
        ]
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