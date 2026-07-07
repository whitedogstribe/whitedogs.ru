{set $seo_title = ($modx->resource->longtitle ?: $modx->resource->pagetitle)|escape}
{set $seo_desc = $modx->resource->description|notags|ellipsis: 255|escape}
{set $seo_img = ''}

<title>{$seo_title} | {$site_name}</title>
<meta name="description" content="{$seo_desc}">

<meta property="og:type" content="website" />
<meta property="og:url" content="{$site_url}{$modx->resource->uri}" />
<meta property="og:title" content="{$seo_title} | {$site_name}" />
<meta property="og:description" content="{$seo_desc}" />
{if $seo_img}
    <meta property="twitter:image" content="{$site_url}{$seo_img|glide:'w=1230&h=630&fit=crop&fm=webp'}" />
    <meta property="og:image" content="{$site_url}{$seo_img|glide:'w=1230&h=630&fit=crop&fm=webp'}" />
    <meta property="og:image:width" content="1200" />
    <meta property="og:image:height" content="630" />
{/if}
<meta property="og:locale" content="ru_RU" />
<meta property="og:site_name" content="{$site_name}" />
<meta name="twitter:card" content="summary_large_image" />
<meta name="twitter:url" content="{$site_url}{$modx->resource->uri}" />
<meta name="twitter:title" content="{$seo_title} | {$site_name}" />
<meta name="twitter:description" content="{$seo_desc}" />