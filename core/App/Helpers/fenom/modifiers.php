<?php

use PageBlocks\App\Models\Country;
use PageBlocks\App\Models\PbTableData;
use PageBlocks\App\Models\Product;
use PageBlocks\App\Models\Tour;

return [
    'editorjs' => function ($input, string $options = '') {
        if (empty($input)) return '';

        $editorjs = $this->modx->services->get('editorjs');
        $content = json_decode($input, 1);
        if (!isset($content['blocks'])) {
            return $input;
        }

        $equipmentFieldIds = ['equipment' => 406, 'equipment_guide' => 407];
        $resourceId = $this->modx->resource->id ?? 0;

        $html = '';
        $editorjsBlocks = [];

        foreach ($content['blocks'] as $block) {
            if (isset($equipmentFieldIds[$block['type']])) {
                // Flush accumulated EditorJS blocks first
                if ($editorjsBlocks) {
                    $html .= $editorjs->render($editorjsBlocks);
                    $editorjsBlocks = [];
                }
                // Render equipment directly
                $fieldId = $equipmentFieldIds[$block['type']];
                $items = PbTableData::where([
                    'constructor_id' => 35,
                    'field_id' => $fieldId,
                    'model_id' => $resourceId,
                    'model_type' => 'PageBlocks\\App\\Models\\BlogPost',
                ])->orderBy('menuindex')->get();

                if ($items->isNotEmpty()) {
                    $html .= '<div class="row equipment-list">';
                    foreach ($items as $item) {
                        $data = $item->data;
                        $imgRaw = isset($data['img']) ? (is_string($data['img']) ? json_decode($data['img'], true) : $data['img']) : [];
                        // img may be stored as plain path string instead of JSON object
                        if (!is_array($imgRaw) && !empty($data['img']) && is_string($data['img'])) {
                            $imgUrl = $data['img'];
                        } else {
                            $imgUrl = $imgRaw['url'] ?? '';
                        }
                        $title       = $data['title'] ?? '';
                        $brand       = $data['brand'] ?? '';
                        $where       = $data['where'] ?? '';
                        $description = $data['description'] ?? '';

                        $imgHtml = '';
                        if ($imgUrl) {
                            $imgUrl = str_replace('\\/', '/', $imgUrl);
                            $glideUrl = file_exists(MODX_BASE_PATH . $imgUrl)
                                ? \Boshnik\PageBlocks\Facades\Glide::url($imgUrl, 'w=220&fit=crop&fm=webp')
                                : '/' . $imgUrl;
                            $imgHtml = '<img loading="lazy" src="' . htmlspecialchars($glideUrl) . '" class="img-fluid" alt="' . htmlspecialchars($title) . '" />';
                        }

                        $html .= '<div class="col-12">';
                        $html .= '<div class="row">';
                        $html .= '<div class="col-xs-12 col-sm-4">' . $imgHtml . '</div>';
                        $html .= '<div class="col-xs-12 col-sm-8">';
                        $html .= '<h5>' . htmlspecialchars($title) . '</h5>';
                        if ($description) {
                            $html .= '<div class="equipment-description">' . $description . '</div>';
                        }
                        $html .= '<blockquote>';
                        if ($where) {
                            $html .= '<strong>Где купить:</strong> ' . htmlspecialchars($where) . '<br />';
                        }
                        if ($brand) {
                            $html .= '<strong>Предпочтительные бренды:</strong> ' . htmlspecialchars($brand);
                        }
                        $html .= '</blockquote>';
                        $productsRaw = $data['products'] ?? [];
                        if (is_string($productsRaw)) {
                            $productsRaw = json_decode($productsRaw, true) ?? [];
                        }
                        if (!empty($productsRaw)) {
                            $productIds = array_column($productsRaw, 'id') ?: $productsRaw;
                            $productIds = array_filter(array_map('intval', $productIds));
                            if ($productIds) {
                                $products = \PageBlocks\App\Models\Product::whereIn('id', $productIds)
                                    ->orderBy('menuindex')
                                    ->published()
                                    ->get();
                                if ($products->isNotEmpty()) {
                                    $html .= '<div class="row">';
                                    foreach ($products as $product) {
                                        $html .= view('file:chunks/shop/article', [
                                            'id'    => $product->id,
                                            'url'   => '/shop/' . $product->alias,
                                            'title' => $product->title,
                                            'img'   => $product->image,
                                            'rent'  => $product->rent,
                                            'price' => $product->price_format,
                                        ]);
                                    }
                                    $html .= '</div>';
                                }
                            }
                        }
                        $html .= '</div>';
                        $html .= '</div>';
                        $html .= '</div>';
                    }
                    $html .= '</div>';
                }
            } else {
                $editorjsBlocks[] = $block;
            }
        }

        // Render any remaining EditorJS blocks
        if ($editorjsBlocks) {
            $html .= $editorjs->render($editorjsBlocks);
        }

        return $html;
    },
    'users' => function () {
        return query('modUser')
            ->alias('user')
            ->where(['active' => 1])
            ->join('modUserProfile', 'profile', 'user.id = profile.internalKey')
            ->select('user.*,profile.*')
            ->get();
    },
    'user_total' => function () {
        return query('modUser')
            ->where(['active' => 1])
            ->cache(86400)
            ->count();
    },
    'faqParser' => function ($content) {
//        $discount = number_format($price * 0.2, 0, '.', ' ');
//        $date2 = new DateTime($this->modx->resource->dates[0]['start_date']);
//        $date2->modify('-2 months');
//        $date2 = $date2->format('d.m.y');
//
//        $date3 = new DateTime($this->modx->resource->dates[0]['start_date']);
//        $date3->modify('-2 months');
//        $date3 = $date3->format('d.m.y');

        $content = str_replace('{country}', "страну {$this->modx->resource->country_name}", $content);
        $content = str_replace('{city}', "городе {$this->modx->resource->city_name}", $content);
        $content = str_replace('{price}', "<span class='fw-bold faq-discount-price'></span>", $content);
        $content = str_replace('{date}', "<span class='fw-bold faq-2-months'></span>", $content);
        $content = str_replace('{date2}', "<span class='fw-bold faq-2-months'></span>", $content);
        $content = str_replace('{date3}', "<span class='fw-bold faq-3-months'></span>", $content);

        $content = str_replace('href="go"', 'href="/'.$this->modx->resource->uri.'/go"', $content);

        return $content;
    },
    'renderPlaceholder' => function ($content) {

        $country = $this->modx->resource->country_name ?? '';
        $city = $this->modx->resource->city_name ?? '';
        $price = $this->modx->resource->price ?? 0;
        $guide = $this->modx->resource->guide ?? 'Эрадж Шамс';
        $date = $this->modx->resource->date_range;

        $content = str_replace('{country}', $country, $content);
        $content = str_replace('{city}', $city, $content);
        $content = str_replace('{price}', $price, $content);
        $content = str_replace('{guide}', $guide, $content);
        $content = str_replace('{data}', $date, $content);
        $content = str_replace('{date}', $date, $content);

        return $content;
    },
    'instructors' => function () {
        return query('team')
            ->where(function($q) {
                $q->whereNotNull('published_at')
                    ->where('published_at', '<=', now())
                    ->where('group', 'instructor');
            })
            ->orWhere('id', 1)
            ->orderBy('menuindex')
            ->select('id', 'name')
            ->get()
            ->toArray();
    },
    'team_names' => function () {
        return query('team')
            ->whereNotNull('published_at')
            ->where('published_at', '<=', now())
            ->orderBy('menuindex')
            ->select('id', 'name')
            ->get()
            ->toArray();
    },
    'countries' => function () {
        return query('countries')
            //->whereNotNull('published_at')
            ->where('published_at', '<=', now())
            //->orderBy('menuindex')
            ->select('id', 'name', 'alias')
            ->get()
            ->toArray();
    },
    'tourTypes' => function () {
        return query('tour_type')
            ->orderBy('menuindex')
            ->select('id', 'name', 'alias')
            ->get()
            ->toArray();
    },
    'blog' => function ($id) {
        return '/blog/' . query('blog_posts')->where('id', $id)->value('alias');
    },
    'tours' => function (array $ids = []) {
        if ($ids) {
            $placeholders = implode(',', array_fill(0, count($ids), '?'));
            return Tour::whereIn('id', $ids)
                ->with('dates', 'image', 'nearestDate')
                ->orderByRaw("FIELD(id, {$placeholders})", $ids)
                ->published()
                ->get()
                ->toArray();
        }

        return Tour::with('dates')
            ->orderByDate()
            ->get();

    },
    'reviews' => function ($ids = [], $limit = 1000) {
        if (!is_array($ids) || !count($ids)) return '';
        $placeholders = implode(',', array_fill(0, count($ids), '?'));

        return PbTableData::with('tour')
            ->where([
                'constructor_id' => 23,
                'field_id' => 276,
//                'field_name' => 'reviews',
            ])
            ->whereNotNull('published_at')
            ->where('published_at', '<=', now())
            ->when($ids, function ($q, $ids) {
                $q->whereIn('model_id', $ids);
            })
            ->select('id', 'data', 'model_id', 'published_at')
            ->orderByRaw("FIELD('model_id', {$placeholders})", $ids)
            ->orderBy('published_at', 'desc')
            ->limit($limit)
            ->get()
            ->map(function ($review) {
                $data = $review->data;
                $data['id'] = $review->id;
                $data['tour'] = $review->tour;
                $data['published_at'] = $review->published_at;
                return $data;
            })
            ->toArray();

    },
    'lastReviews' => function ($limit = 10) {
        return PbTableData::with('tour')
            ->where([
                'constructor_id' => 23,
                'field_id' => 276,
            ])
            ->whereNotNull('published_at')
            ->where('published_at', '<=', now())
            ->select('id', 'data', 'model_id', 'published_at')
            ->orderBy('published_at', 'desc')
            ->limit($limit)
            ->get()
            ->map(function ($review) {
                $data = $review->data;
                $data['id'] = $review->id;
                $data['tour'] = $review->tour;
                $data['published_at'] = $review->published_at;
                return $data;
            })
            ->toArray();
    },
    'routes' => function ($ids = '') {

        if (!is_array($ids)) {
            $ids = explode(',', $ids);
        }

        return Tour::whereIn('id', $ids)
            ->with('nearestDate', 'image')
            ->orderByDate()
            ->published()
            ->get()
            ->map(function ($tour) {
                return view('file:chunks/tours/article', [
                    'url' => '/tours/' . $tour->alias,
                    'title' => $tour->title,
                    'img' => $tour->image,
                    'date' => $tour->date_range,
                    'price' => $tour->price,
                ]);
            })->implode('');
    },
    'shop' => function ($ids = '') {
        if (empty($ids)) {
            return '';
        }

        if (!is_array($ids)) {
            $ids = array_filter(array_map('intval', explode(',', $ids)));
        } else {
            $ids = array_filter(array_map('intval', $ids));
        }

        if (empty($ids)) {
            return '';
        }

        return Product::whereIn('id', $ids)
            ->whereHas('category', fn($q) => $q->where('alias', 'equipment'))
            ->orderBy('menuindex')
            ->published()
            ->get()
            ->map(function ($item) {
                return view('file:chunks/shop/article', [
                    'id' => $item->id,
                    'url' => '/shop/' . $item->alias,
                    'title' => $item->title,
                    'img' => $item->image,
                    'rent' => $item->rent,
                    'price' => $item->price_format,
                ]);
            })->implode('');
    },
    'urlName' => function ($name) {
        $id = match ($name) {
            'tours' => 2,
            'reviews' => 3,
            'team' => 4,
            'blog' => 5,
        };

        return query('site_content')
            ->where(['id' => $id])
            ->value('uri');
    },
    'dateRange' => function ($startDate, $endDate, $locale = 'ru') {
        if (empty($startDate) || empty($endDate)) {
            return '';
        }

        $start = strtotime($startDate);
        $end = strtotime($endDate);

        $startDay = date('d', $start);
        $endDay = date('d', $end);
        $startMonth = date('F', $start);
        $endMonth = date('F', $end);
        $startYear = date('Y', $start);
        $endYear = date('Y', $end);

        $months = [
            'January' => 'января',   'February' => 'февраля',
            'March' => 'марта',     'April' => 'апреля',
            'May' => 'мая',         'June' => 'июня',
            'July' => 'июля',       'August' => 'августа',
            'September' => 'сентября','October' => 'октября',
            'November' => 'ноября', 'December' => 'декабря',
        ];

        if ($locale === 'ru') {
            $startMonth = $months[$startMonth];
            $endMonth = $months[$endMonth];
        }

        // Один месяц
        if (date('Y-m', $start) === date('Y-m', $end)) {
            return ltrim($startDay, '0') . '-' . ltrim($endDay, '0') . ' ' . $startMonth . ' ' . $startYear;
        }

        // Разные месяцы, один год
        if ($startYear === $endYear) {
            return ltrim($startDay, '0') . ' ' . $startMonth . ' - ' . ltrim($endDay, '0') . ' ' . $endMonth . ' ' . $startYear;
        }

        // Разные годы
        return ltrim($startDay, '0') . ' ' . $startMonth . ' ' . $startYear . ' - ' . ltrim($endDay, '0') . ' ' . $endMonth . ' ' . $endYear;
    },
    'render' => function ($template, array $params = []) {
        if (empty($template)) {
            return '';
        }
        return view("@INLINE $template", $params);
    },
    'snippet' => function ($name, array $params = []) {
        if (empty($name)) {
            return '';
        }
        $path = "file:chunks/blogs/snippet_{$name}.tpl";
        try {
            return view($path, array_merge(['modx' => modx()], $params));
        } catch (\Throwable $e) {
            return '';
        }
    },
    'trim' => function ($string) {
        if (empty($string)) {
            return '';
        }
        return trim($string);
    },
    'gender' => function (string $first = '', string $last = '', string $middle = ''): string {
        $isShortenedName = fn(string $name) => (bool)preg_match('/^\p{L}{1,3}\.$/u', trim($name));

        $last = $isShortenedName($last) ? '' : $last;
        $first = $isShortenedName($first) ? '' : $first;
        $middle = $isShortenedName($middle) ? '' : $middle;

        if ($middle) {
            if (preg_match('/ович$|евич$/ui', $middle)) return 'male';
            if (preg_match('/овна$|евна$|ична$/ui', $middle)) return 'female';
        }

        $firstGender = null;
        if ($first && mb_strlen($first) > 3 && !preg_match('/[a-z]$/i', $first)) {
            if (preg_match('/й$|он$|ан$|ен$|ин$|ун$|ор$|ар$|ер$|ир$|ур$|ел$|ил$|ол$|ем$|им$|ит$|ов$|ев$|ид$|иг$/ui', $first)) $firstGender = 'male';
            elseif (preg_match('/а$|я$|ь$/u', $first)) $firstGender = 'female';
        }

        if ($firstGender) return $firstGender;

        if ($last && !preg_match('/^\p{L}{1,4}$/u', $last)) {
            if (preg_match('/ов$|ев$|ёв$|ин$|ын$|ский$|цкий$|зский$|ной$/ui', $last)) return 'male';
            if (preg_match('/ова$|ева$|ёва$|ина$|ына$|ская$|цкая$|зская$|ная$/ui', $last)) return 'female';
        }

        return 'male';
    },

    'countryNames' => function (array $aliases) {
        return \PageBlocks\App\Models\Country::whereIn('alias', $aliases)
            ->pluck('name')
            ->implode(', ');
    },
    'addDays' => function (string $date, int $days): string {
        $months = [
            1  => 'января',
            2  => 'февраля',
            3  => 'марта',
            4  => 'апреля',
            5  => 'мая',
            6  => 'июня',
            7  => 'июля',
            8  => 'августа',
            9  => 'сентября',
            10 => 'октября',
            11 => 'ноября',
            12 => 'декабря',
        ];

        $dt = new DateTime($date);
        $dt->modify("+{$days} days");

        return $dt->format('j') . ' ' . $months[(int) $dt->format('n')];
    },
];