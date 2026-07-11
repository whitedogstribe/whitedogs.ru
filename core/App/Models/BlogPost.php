<?php

namespace PageBlocks\App\Models;

use PageBlocks\App\Models\Base\BaseBlogPost;
use PageBlocks\App\Traits\HasViews;

class BlogPost extends BaseBlogPost
{
    use HasViews;
    protected array $copiableRelations = [];

    const CATEGORY_ARTICLES = 'articles';
    const CATEGORY_EQUIPMENT = 'equipment';
    const CATEGORY_GUIDES = 'guides';
    const CATEGORY_REPORTS = 'reports';
    const CATEGORY_TIPS = 'tips';

    /**
     * Получить все доступные категории
     */
    public static function getCategories(): array
    {
        return [
            self::CATEGORY_ARTICLES => 'Статьи',
            self::CATEGORY_EQUIPMENT => 'Снаряжение',
            self::CATEGORY_GUIDES => 'Гайды',
            self::CATEGORY_REPORTS => 'Отчеты',
            self::CATEGORY_TIPS => 'Советы'
        ];
    }

    protected static function boot()
    {
        parent::boot();
        static::creating(function ($model) {
            if (is_null($model->menuindex) || $model->menuindex === 0) {
                $model->menuindex = (static::max('menuindex') ?? 0) + 1;
            }

            if (!is_numeric($model->user_id)) {
                $model->user_id = 0;
            }
            if (!is_numeric($model->author_id)) {
                $model->author_id = 0;
            }
        });

        static::updating(function ($model) {
            if (!is_numeric($model->user_id)) {
                $model->user_id = 0;
            }
            if (!is_numeric($model->author_id)) {
                $model->author_id = 0;
            }
        });

        static::saved(function ($model) {
            if (empty($model->img) || empty($model->alias)) {
                return;
            }
            $img = is_array($model->img) ? $model->img : json_decode($model->img, true);
            if (!is_array($img) || strpos($img['url'] ?? '', 'pbtempfile') === false) {
                return;
            }
            $oldPath = $img['url'];
            $img['url'] = str_replace('pbtempfile', $model->alias, $img['url']);
            if (isset($img['path'])) {
                $img['path'] = str_replace('pbtempfile', $model->alias, $img['path']);
            }
            $oldFull = MODX_BASE_PATH . $oldPath;
            $newFull = MODX_BASE_PATH . $img['url'];
            if (file_exists($oldFull)) {
                $dir = dirname($newFull);
                if (!is_dir($dir)) {
                    mkdir($dir, 0755, true);
                }
                rename($oldFull, $newFull);
            }
            query('blog_posts')->where('id', $model->id)->update([
                'img' => json_encode($img, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES),
            ]);
        });
    }

    public function team()
    {
        return $this->belongsTo(Team::class, 'author_id');
    }

    public function user()
    {
        return $this->belongsTo(UserProfile::class, 'user_id', 'internalKey');
    }

    /**
     * Получить название категории
     */
    public function getCategoryName(): string
    {
        $categories = self::getCategories();
        return $categories[$this->category] ?? $this->category;
    }

    /**
     * Увеличить счетчик просмотров
     */
    public function incrementViews(): void
    {
        $this->increment('views');
    }

    /**
     * Scope для фильтрации по категории
     */
    public function scopeCategory($query, string $category)
    {
        return $query->where('category', $category);
    }

    /**
     * Scope для получения последних постов
     */
    public function scopeLatest($query, int $limit = 10)
    {
        return $query->orderBy('published_at', 'desc')->limit($limit);
    }

    public function scopePopular($query, int $limit = 10)
    {
        return $query->orderBy('views', 'desc')->limit($limit);
    }

    public function scopeEquipment($query, int $limit = 10)
    {
        return $query->where('category', 'equipment')->limit($limit);
    }

    public function scopeOrdered($query)
    {
        return $query->orderBy('published_at', 'desc');
    }


    public function getUrl(): string
    {
        return "/blog/{$this->alias}";
    }

    public function getExcerpt(int $length = 150): string
    {
        if ($this->description) {
            return mb_substr($this->description, 0, $length) .
                (mb_strlen($this->description) > $length ? '...' : '');
        }

        if ($this->old_content) {
            $content = strip_tags($this->old_content);
            return mb_substr($content, 0, $length) .
                (mb_strlen($content) > $length ? '...' : '');
        }

        if ($this->content) {
            $editorjs = modx()->services->get('editorjs');
            $content = json_decode($this->content,1);
            if (isset($content['blocks'])) {
                $content = $editorjs->render($content['blocks']);
                $content = strip_tags($content);
                return mb_substr($content, 0, $length) .
                    (mb_strlen($content) > $length ? '...' : '');
            }
        }

        return '';
    }

    public function getImageAttribute()
    {
        return $this->img ?? '';
    }

    public function getPublishedonAttribute(): int
    {
        return $this->published_at ? \Carbon\Carbon::parse($this->published_at)->timestamp : 0;
    }

    public function publishedAtRu(string $format = 'd F Y'): string
    {
        if (!$this->published_at) return '';
        $months = [
            1=>'января',2=>'февраля',3=>'марта',4=>'апреля',5=>'мая',6=>'июня',
            7=>'июля',8=>'августа',9=>'сентября',10=>'октября',11=>'ноября',12=>'декабря',
        ];
        $date = \Carbon\Carbon::parse($this->published_at);
        return $date->format('d') . ' ' . $months[(int)$date->format('n')] . ' ' . $date->format('Y');
    }

    public function prev(): ?self
    {
        return static::whereNotNull('published_at')
            ->where('published_at', '<=', now())
            ->whereNull('deleted_at')
            ->where('published_at', '>', $this->published_at)
            ->orderBy('published_at', 'asc')
            ->first();
    }

    public function next(): ?self
    {
        return static::whereNotNull('published_at')
            ->where('published_at', '<=', now())
            ->whereNull('deleted_at')
            ->where('published_at', '<', $this->published_at)
            ->orderBy('published_at', 'desc')
            ->first();
    }
}