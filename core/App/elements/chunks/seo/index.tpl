{set $site_url = $modx->config.site_url}

{set $nearestTours = model('Tour')->with(['dates', 'image', 'nearestDate'])->orderByDate()->published()->limit(10)->get()}

{set $featuredTours = []}
{foreach $nearestTours as $idx => $tour}
    {set $featuredTours[] = [
        '@type' => 'ListItem',
        'position' => $idx + 1,
        'item' => [
            '@type' => 'TouristTrip',
            'name' => $tour->title,
            'url' => $site_url ~ $tour->alias,
            'offers' => [
                '@type' => 'Offer',
                'price' => $tour->clear_price,
                'priceCurrency' => $tour->currency,
                'availability' => $tour->is_sold_out
                    ? 'https://schema.org/SoldOut'
                    : 'https://schema.org/InStock',
            ],
        ],
    ]}
{/foreach}

{set $schema = [
    '@context' => 'https://schema.org',
    '@graph' => [
        [
            '@type' => 'TravelAgency',
            '@id' => $site_url ~ '#organization',
            'name' => $modx->config.site_name,
            'alternateName' => 'White Dogs Tribe',
            'url' => $site_url,
            'logo' => [
                '@type' => 'ImageObject',
                'url' => $site_url ~ 'assets/images/logo.svg',
                'contentUrl' => $site_url ~ 'assets/images/logo.svg',
            ],
            'image' => $site_url ~ 'assets/images/logo.svg',
            'description' => $modx->resource->description,
            'foundingDate' => '2018',
            'legalName' => 'ООО «'~$modx->config.site_name~'»',
            'taxID' => '7751331680',
            'contactPoint' => [
                [
                    '@type' => 'ContactPoint',
                    'contactType' => 'customer support',
                    'url' => $modx->config.telegram|replace:'@':'https://t.me/',
                ],
                [
                    '@type' => 'ContactPoint',
                    'contactType' => 'customer support',
                    'telephone' => $modx->config.whatsapp|phone
                ],
                [
                    '@type' => 'ContactPoint',
                    'contactType' => 'sales',
                    'url' => $modx->config.business_telegram|replace:'@':'https://t.me/',
                    'description' => 'Сотрудничество',
                ],
            ],
            'email' => $modx->config.email,
            'sameAs' => [
                "{$modx->config.social_telegram}",
                "{$modx->config.social_vk}",
                "{$modx->config.social_instagram}",
                "{$modx->config.social_youtube}"
            ],
        ],
        [
            '@type' => 'WebSite',
            '@id' => $site_url ~ '#website',
            'url' => $site_url,
            'name' => $modx->config.site_name,
            'description' => $modx->resource->description
            'publisher' => ['@id' => $site_url ~ '#organization'],
            'potentialAction' => [
                '@type' => 'SearchAction',
                'target' => [
                    '@type' => 'EntryPoint',
                    'urlTemplate' => $site_url ~ 'route?q={search_term_string}',
                ],
                'query-input' => 'required name=search_term_string',
            ],
        ],

        [
            '@type' => 'WebPage',
            '@id' => $site_url ~ '#webpage',
            'url' => $site_url,
            'name' => $modx->resource->pagetitle,
            'description' => $modx->resource->description,
            'isPartOf' => ['@id' => $site_url ~ '#website'],
            'about' => ['@id' => $site_url ~ '#organization'],
            'inLanguage' => 'ru',
        ],
        [
            '@type' => 'ItemList',
            '@id' => $site_url ~ '#featured-tours',
            'name' => 'Ближайшие путешествия',
            'url' => $site_url,
            'itemListElement' => $featuredTours,
        ],

    ],
]}

<script type="application/ld+json">{$schema|toJSON}</script>