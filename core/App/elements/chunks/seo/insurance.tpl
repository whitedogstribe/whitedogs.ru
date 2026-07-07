{set $site_url = $modx->config.site_url}
{set $schema = [
    '@context' => 'https://schema.org',
    '@graph' => [
        [
            '@type' => 'FAQPage',
            'mainEntity' => [
                [
                    '@type' => 'Question',
                    'name' => 'Что включено в страховку?',
                    'acceptedAnswer' => [
                        '@type' => 'Answer',
                        'text' => 'Всё необходимое на время похода. Страховая компания покроет расходы на медицинское лечение и экстренное возвращение на родину. Если нужен полис только для визы — выбирайте базовый вариант.',
                    ],
                ],
                [
                    '@type' => 'Question',
                    'name' => 'Уже в пути, вспомнил, что не оформил страховку. Как теперь быть?',
                    'acceptedAnswer' => [
                        '@type' => 'Answer',
                        'text' => 'Купить страховой полис можно прямо сейчас, вне зависимости от местоположения. При поиске укажите "Я уже за границей" и выберите период от 3 до 5 дней от текущей даты.',
                    ],
                ],
            ],
        ],
        [
            '@type' => 'BreadcrumbList',
            'itemListElement' => [
                ['@type' => 'ListItem', 'position' => 1, 'name' => 'Главная', 'item' => $site_url],
                ['@type' => 'ListItem', 'position' => 2, 'name' => $modx->resource->pagetitle, 'item' => $site_url ~ $modx->resource->uri],
                ['@type' => 'ListItem', 'position' => 3, 'name' => 'Страховка', 'item' => $site_url ~ $modx->resource->uri ~ '/go'],
            ],
        ],
    ],
]}

<script type="application/ld+json">{$schema|toJSON}</script>