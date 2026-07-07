{set $site_name = $modx->config.site_name}
{set $site_url = $modx->config.site_url}
{set $seo_title = ($modx->resource->title ?: $modx->resource->pagetitle)|renderPlaceholder|escape}
{set $seo_desc = ($modx->resource->seo_desc ?: $modx->resource->description)|renderPlaceholder|notags|ellipsis: 255|escape}
{set $img = $modx->resource->image ? ($modx->resource->image|fromJSON) : ''}
{set $seo_img = $modx->resource->seo_img ? $modx->resource->seo_img : ($img ? $img.url : '')}

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