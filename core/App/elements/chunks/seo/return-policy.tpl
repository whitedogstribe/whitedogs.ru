{set $site_url = $modx->config.site_url}
{set $schema = [
    '@context' => 'https://schema.org',
    '@graph' => [
        [
            '@type' => ['DigitalDocument', 'MerchantReturnPolicy'],
            'name' => $modx->resource->pagetitle,
            'url' => $site_url ~ $modx->resource->alias,
            'datePublished' => $modx->resource->publishedon|date:'Y-m-d',
            'dateModified' => $modx->resource->editedon|date:'Y-m-d',
            'inLanguage' => 'ru',
            'description' => $modx->resource->description,
            'publisher' => ['@id' => $site_url ~ '#organization'],
            'about' => ['@id' => $site_url ~ '#organization'],
            'applicableCountry' => 'RU',
            'returnPolicyCategory' => 'https://schema.org/MerchantReturnFiniteReturnWindow',
            'merchantReturnDays' => 30,
            'returnMethod' => 'https://schema.org/ReturnByMail',
            'refundType' => 'https://schema.org/FullRefund',
            'returnFees' => 'https://schema.org/FreeReturn',
        ],
        [
            '@type' => 'BreadcrumbList',
            'itemListElement' => [
                ['@type' => 'ListItem', 'position' => 1, 'name' => 'Главная', 'item' => $site_url],
                ['@type' => 'ListItem', 'position' => 2, 'name' => $modx->resource->pagetitle, 'item' => $site_url ~ $modx->resource->alias],
            ],
        ],
    ],
]}

<script type="application/ld+json">{$schema|toJSON}</script>