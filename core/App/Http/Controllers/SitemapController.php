<?php

namespace PageBlocks\App\Http\Controllers;

use Boshnik\PageBlocks\Http\Request;
use Boshnik\PageBlocks\Support\Cache;

class SitemapController extends BaseController
{
    private const SITEMAP_CONTENT_TYPE = 1;
    private const CACHE_TTL = 3600;

    protected string $site_url;

    private array $priorityMap = [
        'home'    => '1.0',
        'default' => '0.5',
    ];

    private array $changeFreqMap = [
        'home'    => 'daily',
        'default' => 'monthly',
    ];

    // Alias → query config
    private array $aliasMap = [
        'resources' => [
            'table'      => 'site_content',
            'select'     => ['id', 'uri', 'alias', 'context_key', 'editedon', 'createdon'],
            'conditions' => ['content_type' => self::SITEMAP_CONTENT_TYPE],
            'url_field'  => 'uri',
            'date_field'   => 'editedon',
            'create_field' => 'createdon',
        ],
        'tours' => [
            'table'      => 'tours',
            'select'     => ['id', 'alias', 'created_at', 'updated_at'],
            'conditions' => [],
            'url_prefix' => 'tours',
            'url_field'  => 'alias',
            'date_field'   => 'updated_at',
            'create_field' => 'created_at',
        ],
        'blog' => [
            'table'      => 'blog_posts',
            'select'      => ['id', 'alias', 'created_at', 'updated_at'],
            'conditions' => [],
            'url_prefix'  => 'blog',
            'url_field'  => 'alias',
            'date_field'   => 'updated_at',
            'create_field' => 'created_at',
        ],
        'team' => [
            'table'      => 'team',
            'select'      => ['id', 'alias', 'created_at', 'updated_at'],
            'conditions' => [],
            'url_prefix'  => 'team',
            'url_field'  => 'alias',
            'date_field'   => 'updated_at',
            'create_field' => 'created_at',
        ],
        'products' => [
            'table'      => 'products',
            'select'      => ['id', 'alias', 'created_at', 'updated_at'],
            'conditions' => [],
            'url_prefix'  => 'shop',
            'url_field'  => 'alias',
            'date_field'   => 'updated_at',
            'create_field' => 'created_at',
        ],
        'countries' => [
            'table'      => 'countries',
            'select'      => ['id', 'alias', 'created_at', 'updated_at'],
            'conditions' => [],
            'url_prefix'  => 'countries',
            'url_field'  => 'alias',
            'date_field'   => 'updated_at',
            'create_field' => 'created_at',
        ],
        'tourtype' => [
            'table'      => 'tour_type',
            'select'      => ['id', 'alias', 'created_at', 'updated_at'],
            'conditions' => [],
            'url_prefix'  => 'tourtype',
            'url_field'  => 'alias',
            'date_field'   => 'updated_at',
            'create_field' => 'created_at',
        ],
    ];

    protected string $alias = 'resources';

    public function index(Request $request)
    {
        $this->site_url = $this->modx->getOption('site_url');

        $xml = Cache::remember('sitemap_index', self::CACHE_TTL, fn() => $this->buildSitemapIndex());

        return $this->xmlResponse($xml);
    }

    public function show(string $alias, Request $request)
    {
        $this->site_url = $this->modx->getOption('site_url');
        $this->alias = $alias;

        if (!array_key_exists($alias, $this->aliasMap)) {
            return response('Sitemap not found', 404);
        }

        $config = $this->aliasMap[$alias];

        $xml = Cache::remember('sitemap_' . $alias, self::CACHE_TTL, function () use ($config) {
            $items = $this->fetchItems($config);
            return $this->buildSitemap($items, $config);
        });

//        $items  = $this->fetchItems($config);
//        $xml    = $this->buildSitemap($items, $config);

        return $this->xmlResponse($xml);
    }

    // ─────────────────────────────────────────────
    //  Builders
    // ─────────────────────────────────────────────

    private function buildSitemapIndex(): string
    {
        $lines = [];
        $lines[] = '<?xml version="1.0" encoding="UTF-8"?>';
        $lines[] = '<sitemapindex xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">';

        foreach (array_keys($this->aliasMap) as $name) {
            $url = $this->site_url . 'sitemap/' . $name . '.xml';

            $lines[] = '  <sitemap>';
            $lines[] = '    <loc>' . $this->esc($url) . '</loc>';
            $lines[] = '    <lastmod>' . date('Y-m-d') . '</lastmod>';
            $lines[] = '  </sitemap>';
        }

        $lines[] = '</sitemapindex>';

        return implode("\n", $lines);
    }

    private function buildSitemap(array $items, array $config): string
    {
        $siteStart = (int) $this->modx->getOption('site_start', null, 1);
        $dateField   = $config['date_field']   ?? 'editedon';
        $createField = $config['create_field'] ?? 'createdon';

        $lines = [];
        $lines[] = '<?xml version="1.0" encoding="UTF-8"?>';
        $lines[] = '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"';
        $lines[] = '        xmlns:xhtml="http://www.w3.org/1999/xhtml">';

        foreach ($items as $item) {
            $isHome     = $this->alias === 'resources' && isset($item->id) && (int) $item->id === $siteStart;
            $url        = $isHome ? rtrim($this->site_url, '/') : $this->resolveUrl($item, $config);
            $timestamp  = $item->$dateField ?: $item->$createField;
            $lastmod    = date('Y-m-d', is_numeric($timestamp) ? $timestamp : strtotime($timestamp));
            $priority   = $isHome ? $this->priorityMap['home']    : $this->priorityMap['default'];
            $changefreq = $isHome ? $this->changeFreqMap['home']  : $this->changeFreqMap['default'];

            $lines[] = '  <url>';
            $lines[] = '    <loc>' . $this->esc($url) . '</loc>';

//            foreach ($this->getAlternates($item, $url) as $alternate) {
//                $lines[] = '    <xhtml:link rel="alternate"'
//                    . ' hreflang="' . $this->esc($alternate['hreflang']) . '"'
//                    . ' href="'     . $this->esc($alternate['href'])     . '" />';
//            }

            $lines[] = '    <lastmod>'   . $lastmod    . '</lastmod>';
            $lines[] = '    <changefreq>' . $changefreq . '</changefreq>';
            $lines[] = '    <priority>'   . $priority   . '</priority>';
            $lines[] = '  </url>';
        }

        $lines[] = '</urlset>';

        return implode("\n", $lines);
    }

    // ─────────────────────────────────────────────
    //  Helpers
    // ─────────────────────────────────────────────

    /**
     * Fetch rows from the DB according to alias config.
     */
    private function fetchItems(array $config): array
    {
        $q = query($config['table']);

        foreach ($config['conditions'] as $field => $value) {
            $q->where($field, $value);
        }

        return $q->select($config['select'] ?? '*')
            ->get()
            ->toArray();
    }

    /**
     * Build absolute URL for a resource row.
     */
    private function resolveUrl(object $item, array $config): string
    {
        $uri = $item->{$config['url_field'] ?? ''} ?? '';
        $prefix = $config['url_prefix'] ?? '';

        return rtrim($this->site_url, '/')
            . ($prefix ? '/' . $prefix : '')
            . '/' . trim($uri, '/');
    }

    /**
     * Return hreflang alternate links for multi-context setups.
     * Mirrors the MODX snippet's context-aware block.
     */
    private function getAlternates(object $item, string $canonicalUrl): array
    {
        $alternates = [];

        $contextEnable = $this->modx->getOption('pageblocks_context_aware', null, false);
        if (!$contextEnable) {
            return $alternates;
        }

        $contexts     = json_decode($this->modx->getOption('pageblocks_contexts', null, '{}'), true);
        $contextKeys  = array_column($contexts, 'key');
        $currentCtx   = $item->context_key ?? 'web';

        foreach ($contextKeys as $ctxKey) {
            if ($ctxKey === $currentCtx) {
                continue;
            }

            $translated = query('site_content')
                ->where('alias',       $item->alias ?? '')
                ->where('context_key', $ctxKey)
                ->whereNotNull('published_at')
                ->where('published_at', '<=', now())
                ->whereNull('deleted_at')
                ->first();

            if ($translated) {
                $href     = $this->modx->makeUrl($translated->id, $ctxKey, '', 'full');
                $hreflang = $this->modx->getOption('cultureKey', null, $ctxKey);

                $alternates[] = compact('href', 'hreflang');
            }
        }

        return $alternates;
    }

    /**
     * XML-safe escaping.
     */
    private function esc(string $value): string
    {
        return htmlspecialchars($value, ENT_XML1 | ENT_QUOTES, 'UTF-8');
    }

    /**
     * Return an XML HTTP response.
     */
    private function xmlResponse(string $content)
    {
        return response($content)
            ->header('Content-Type', 'application/xml');
    }
}