<?php

namespace PageBlocks\App\Services;

class PaginationViewFactory
{
    protected static string $defaultTemplate = 'bootstrap';

    public static function setDefaultTemplate($template): void
    {
        self::$defaultTemplate = $template;
    }

    public function make($view, $data = []): PaginationView
    {
        $paginationView = new PaginationView($data);
        $paginationView->setTemplate(self::$defaultTemplate);
        return $paginationView;
    }
}

class PaginationView
{
    protected array $data = [];
    protected string $template = 'bootstrap';

    public function __construct($data)
    {
        $this->data = $data;
    }

    public function render(): string
    {
        $paginator = $this->data['paginator'];

        if (!$paginator->hasPages()) {
            return '';
        }

        return match($this->template) {
            'tailwind' => $this->renderTailwind($paginator),
            'simple' => $this->renderSimple($paginator),
            default => $this->renderBootstrap($paginator),
        };
    }

    protected function renderBootstrap($paginator)
    {
        $html = '<nav><ul class="pagination d-flex gap-1 justify-content-center">';

        if ($paginator->onFirstPage()) {
            $html .= '<li class="page-item page-prev me-auto disabled"><span class="page-link ps-0"><i class="bi bi-arrow-left-short"></i> Новые</span></li>';
        } else {
            $prevUrl = $this->getCleanUrl($paginator->previousPageUrl(), $paginator->currentPage() - 1);
            $prevPage = $paginator->currentPage() - 1;
            $html .= '<li class="page-item page-prev me-auto"><a class="page-link ps-0" href="' . $prevUrl . '" data-page="' . $prevPage . '"><i class="bi bi-arrow-left-short"></i> Новые</a></li>';
        }

        foreach ($this->getPageWindow($paginator) as $page) {
            if ($page === '...') {
                $html .= '<li class="page-item disabled"><span class="page-link">...</span></li>';
            } elseif ($page == $paginator->currentPage()) {
                $html .= '<li class="page-item active"><span class="page-link">' . $page . '</span></li>';
            } else {
                $url = $this->getCleanUrl($paginator->url($page), $page);
                $html .= '<li class="page-item"><a class="page-link" href="' . $url . '" data-page="' . $page . '">' . $page . '</a></li>';
            }
        }

        if ($paginator->hasMorePages()) {
            $nextPage = $paginator->currentPage() + 1;
            $html .= '<li class="page-item page-next ms-auto"><a class="page-link pe-0" href="' . $paginator->nextPageUrl() . '" data-page="' . $nextPage . '">Ранние <i class="bi bi-arrow-right-short"></i></a></li>';
        } else {
            $html .= '<li class="page-item page-next ms-auto disabled"><span class="page-link pe-0">Ранние <i class="bi bi-arrow-right-short"></i></span></li>';
        }

        $html .= '</ul></nav>';

        return $html;
    }

    protected function renderTailwind($paginator): string
    {
        $html = '<div class="flex items-center justify-center space-x-2">';

        if (!$paginator->onFirstPage()) {
            $prevUrl = $this->getCleanUrl($paginator->previousPageUrl(), $paginator->currentPage() - 1);
            $html .= '<a href="' . $prevUrl . '" class="px-3 py-2 bg-white border rounded hover:bg-gray-50">←</a>';
        }

        foreach ($this->getPageWindow($paginator) as $page) {
            if ($page === '...') {
                $html .= '<span class="px-3 py-2">...</span>';
            } elseif ($page == $paginator->currentPage()) {
                $html .= '<span class="px-3 py-2 bg-blue-500 text-white border rounded">' . $page . '</span>';
            } else {
                $url = $this->getCleanUrl($paginator->url($page), $page);
                $html .= '<a href="' . $url . '" class="px-3 py-2 bg-white border rounded hover:bg-gray-50">' . $page . '</a>';
            }
        }

        if ($paginator->hasMorePages()) {
            $nextUrl = $this->getCleanUrl($paginator->nextPageUrl(), $paginator->currentPage() + 1);
            $html .= '<a href="' . $nextUrl . '" class="px-3 py-2 bg-white border rounded hover:bg-gray-50">→</a>';
        }

        $html .= '</div>';
        return $html;
    }

    protected function renderSimple($paginator): string
    {
        $html = '<div class="pagination">';

        if (!$paginator->onFirstPage()) {
            $prevUrl = $this->getCleanUrl($paginator->previousPageUrl(), $paginator->currentPage() - 1);
            $html .= '<a href="' . $prevUrl . '">← Назад</a>';
        }

        foreach ($this->getPageWindow($paginator) as $page) {
            if ($page === '...') {
                $html .= '<span class="dots">...</span>';
            } elseif ($page == $paginator->currentPage()) {
                $html .= '<span class="current">' . $page . '</span>';
            } else {
                $url = $this->getCleanUrl($paginator->url($page), $page);
                $html .= '<a href="' . $url . '">' . $page . '</a>';
            }
        }

        if ($paginator->hasMorePages()) {
            $nextUrl = $this->getCleanUrl($paginator->nextPageUrl(), $paginator->currentPage() + 1);
            $html .= '<a href="' . $nextUrl . '">Вперёд →</a>';
        }

        $html .= '</div>';
        return $html;
    }

    protected function getPageWindow($paginator): array
    {
        $current = $paginator->currentPage();
        $last    = $paginator->lastPage();
        $window  = 2;

        $pages = [];

        $pages[] = 1;

        $from = max(2, $current - $window);
        $to   = min($last - 1, $current + $window);

        if ($from > 2) {
            $pages[] = '...';
        }

        for ($i = $from; $i <= $to; $i++) {
            $pages[] = $i;
        }

        if ($to < $last - 1) {
            $pages[] = '...';
        }

        if ($last > 1) {
            $pages[] = $last;
        }

        return $pages;
    }

    protected function getCleanUrl($url, $page)
    {
        if ($page == 1) {
            $parsed = parse_url($url);
            $path = $parsed['path'] ?? '';

            if (!empty($parsed['query'])) {
                parse_str($parsed['query'], $params);
                unset($params['page']);

                if (!empty($params)) {
                    return $path . '?' . http_build_query($params);
                }
            }

            return $path;
        }

        return $url;
    }

    public function setTemplate($template): static
    {
        $this->template = $template;
        return $this;
    }

    public function __toString()
    {
        return $this->render();
    }
}