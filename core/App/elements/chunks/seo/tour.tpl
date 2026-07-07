{set $tourUrl = $modx->config.site_url ~ $modx->resource->uri}
{set $itemList = []}
{foreach $modx->resource->plan as $idx => $item}
    {set $data = $item->data}
    {set $itemList[] = [
        '@type' => 'ListItem',
        'position' => $idx+1,
        'name' => $data.title,
        'url' => $tourUrl ~ '/' ~ $data.alias,
    ]}
{/foreach}

{set $availability = 'InStock'}
{if $modx->resource->places_left == 0}
    {set $availability = 'SoldOut'}
{elseif $modx->resource->places_left <= 2}
    {set $availability = 'LimitedAvailability'}
{/if}

{set $faqList = []}
{foreach $modx->resource->faq as $idx => $item}
    {set $data = $item['data']}
    {set $faqList[] = [
        '@type' => 'Question',
        'name' => $data.title,
        'acceptedAnswer' => [
            '@type' => 'Answer',
            'text' => $data.content|faqParser|notags
        ]
    ]}
{/foreach}


{set $reviewsList = []}
{foreach $reviews|slice:0:5 as $review}
    {set $reviewsList[] = [
        '@type' => 'Review',
        'author' => [
            '@type' => 'Person',
            'name' => $review.name
        ],
        'reviewBody' => ($review.content|strip_tags|truncate:300:''),
        'datePublished' => $review.createdon|date:'Y-m-d'
    ]}
{/foreach}


<script type="application/ld+json">
    {
        "@context": "https://schema.org",
        "@graph": [
            {
                "@type": "TouristTrip",
                "@id": "{$tourUrl}#tour",
                "name": "{$modx->resource->title}",
                "description": "{($modx->resource->seo_desc ?: $modx->resource->description)|notags|ellipsis: 255}",
                "url": "{$tourUrl}",
                "image": "{$modx->resource->image.url|glide:'w=1200&h=675&fit=crop&fm=webp'}",
                "touristType": {
                    "@type": "Audience",
                    "audienceType": "{$.pb.tour_level[$modx->resource->level]}"
                },
                "itinerary": {
                    "@type": "ItemList",
                    "name": "{$modx->resource->plan_subtitle ?: $modx->resource->plan_title ?: 'План похода'}",
                    "itemListElement": {$itemList|toJSON:320}
                },
                "provider": {
                    "@type": "TravelAgency",
                    "@id": "{$modx->config.site_url}#organization",
                    "name": "{$modx->config.site_naem}",
                    "url": "{$modx->config.site_url}",
                    "logo": "{$modx->config.site_url}assets/images/logo.svg",
                    "sameAs": [
                        "{$modx->config.social_telegram}",
                        "{$modx->config.social_vk}",
                        "{$modx->config.social_instagram}",
                        "{$modx->config.social_youtube}"
                    ]
                },
                "offers": {
                    "@type": "Offer",
                    "url": "{$url}",
                    "priceCurrency": "{$modx->resource->dates[0]['currency']}",
                    "price": "{$modx->resource->clear_price}",
                    "availability": "https://schema.org/{$availability}",
                    "validFrom": "{$modx->resource->created_at|date:'Y-m-d'}",
                    "priceValidUntil": "{$modx->resource->date_start|date:'Y-m-d'}"
                }
            }, {
                "@type": "Event",
                "@id": "{$tourUrl}#event",
                "name": "{$modx->resource->title}",
                "startDate": "{$modx->resource->start_date|date:'Y-m-d'}",
                "endDate": "{$modx->resource->end_date|date:'Y-m-d'}",
                "duration": "P{$modx->resource->days_count}D",
                "url": "{$tourUrl}",
                "organizer": {
                    "@id": "{$modx->config.site_url}#organization"
                },
                "subjectOf": {
                    "@id": "{$tourUrl}#tour"
                },
                "review": {$reviewsList|toJSON}
            }, {
                "@type": "BreadcrumbList",
                "itemListElement": [
                    {
                        "@type": "ListItem",
                        "position": 1,
                        "name": "Главная",
                        "item": "{$modx->config.site_url}"
                    },
                    {
                        "@type": "ListItem",
                        "position": 2,
                        "name": "Туры",
                        "item": "{$modx->config.site_url}tours"
                    },
                    {
                        "@type": "ListItem",
                        "position": 3,
                        "name": "{$modx->resource->pagetitle}",
                        "item": "{$modx->config.site_url}{$modx->resource->uri}"
                    }
                ]
            },
            {
                "@type": "FAQPage",
                "mainEntity": {$faqList|toJSON}
            }
        ]
    }
</script>