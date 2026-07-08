<?php

namespace PageBlocks\App\Http\Controllers;

use Boshnik\PageBlocks\Http\Request;
use Boshnik\PageBlocks\Facades\Validator;
use PageBlocks\App\Models\BlogPost;
use PageBlocks\App\Models\Tour;

class SearchController extends BaseController
{
    public function search(Request $request)
    {
        setlocale(LC_TIME, 'ru_RU.UTF-8');
        $query = trim($request->get('q', ''));
        $type  = $request->get('type');

        if (mb_strlen($query) < 2) {
            return response()->json([
                'success' => true,
                'tours'    => [],
                'articles' => [],
                'total'    => 0,
            ]);
        }

        $tours    = (!$type || $type === 'tours') ? $this->searchTours($query)    : [];
        $articles = (!$type || $type === 'articles') ? $this->searchArticles($query) : [];

        return response()->json([
            'success' => true,
            'tours'    => $tours,
            'articles' => $articles,
            'total'    => count($tours) + count($articles),
        ]);
    }

    private function searchTours(string $query): array
    {
            return Tour::with(['dates', 'image', 'nearestDate'])
                ->where(function ($q) use ($query) {
                    $q->where('title', 'LIKE', "%{$query}%")
                        ->orWhereRaw("LOWER(JSON_UNQUOTE(JSON_EXTRACT(data, '$.menutitle'))) LIKE ?", [mb_strtolower("%{$query}%")])
                        ->orWhereRaw("LOWER(JSON_UNQUOTE(JSON_EXTRACT(data, '$.seo_title'))) LIKE ?", [mb_strtolower("%{$query}%")])
                        ->orWhereRaw("LOWER(JSON_UNQUOTE(JSON_EXTRACT(data, '$.seo_desc'))) LIKE ?", [mb_strtolower("%{$query}%")])
                        ->orWhereRaw("LOWER(JSON_UNQUOTE(JSON_EXTRACT(data, '$.seo_keywords'))) LIKE ?", [mb_strtolower("%{$query}%")]);
                })
            ->orderByDate()
            ->published()
            ->limit(10)
            ->get()
            ->map(fn (Tour $tour) => [
                'type'  => 'tour',
                'title' => $tour->title,
                'date'  => $tour->date_range,
                'image' => $tour->image['preview'] ?? $tour->image['url'] ?? '',
                'url'   => 'tours/' . $tour->alias,
            ])
            ->all();
    }

    private function searchArticles(string $query): array
    {
        return BlogPost::query()
            ->select('id', 'title', 'alias', 'preview', 'img', 'published_at')
            ->where(function ($q) use ($query) {
                $q->where('title', 'LIKE', "%{$query}%")
                    ->orWhere('description', 'LIKE', "%{$query}%")
                    ->orWhere('seo_title', 'LIKE', "%{$query}%");
            })
            ->ordered()
            ->published()
            ->limit(10)
            ->get()
            ->map(function (BlogPost $article) {
                $imgData = $article->preview
                    ? $article->preview
                    : (is_string($article->img) ? (json_decode($article->img, true)['url'] ?? '') : '');
                return [
                    'type'  => 'article',
                    'title' => $article->title,
                    'date'  => $article->published_at ? \Carbon\Carbon::parse($article->published_at)->locale('ru')->translatedFormat('j F Y') : '',
                    'image' => $imgData,
                    'url'   => 'blog/' . $article->alias,
                ];
            })
            ->all();
    }
}