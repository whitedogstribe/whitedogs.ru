<?php

namespace PageBlocks\App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Casts\Attribute;

/**
 * Class Resource
 *
 * @property int $id
 * @property string $type
 * @property string $contentType
 * @property string $pagetitle
 * @property string $longtitle
 * @property string $description
 * @property string $alias
 * @property string $link_attributes
 * @property int $published
 * @property int $pub_date
 * @property int $unpub_date
 * @property int $parent
 * @property int $isfolder
 * @property string $introtext
 * @property string $content
 * @property int $richtext
 * @property int $template
 * @property int $menuindex
 * @property int $searchable
 * @property int $cacheable
 * @property int $createdby
 * @property int $createdon
 * @property int $editedby
 * @property int $editedon
 * @property int $deleted
 * @property int $deletedon
 * @property int $deletedby
 * @property int $publishedon
 * @property int $publishedby
 * @property string $menutitle
 * @property int $donthit
 * @property int $privateweb
 * @property int $privatemgr
 * @property int $content_dispo
 * @property int $hidemenu
 * @property string $class_key
 * @property string $context_key
 * @property int $content_type
 * @property string $uri
 * @property int $uri_override
 * @property int $hide_children_in_tree
 * @property int $show_in_tree
 * @property array|null $properties
 * @property int $alias_visible
 * @property-read Resource|null $parentResource
 * @property-read Template|null $templateResource
 */
class Resource extends Model
{
    protected $table = 'site_content';
    protected $primaryKey = 'id';
    protected $dateFormat = 'U';

    const CREATED_AT = 'createdon';
    const UPDATED_AT = 'editedon';
    const DELETED_AT = 'deletedon';

    protected $fillable = [
        'type', 'contentType', 'pagetitle', 'longtitle', 'description',
        'alias', 'link_attributes', 'published', 'pub_date', 'unpub_date',
        'parent', 'isfolder', 'introtext', 'content', 'richtext',
        'template', 'menuindex', 'searchable', 'cacheable',
        'createdby', 'editedby', 'deleted', 'deletedby', 'publishedon', 'publishedby',
        'menutitle', 'donthit', 'privateweb', 'privatemgr',
        'content_dispo', 'hidemenu', 'class_key', 'context_key',
        'content_type', 'uri', 'uri_override', 'hide_children_in_tree',
        'show_in_tree', 'properties', 'alias_visible'
    ];

    protected $casts = [
        'id' => 'integer',
        'published' => 'boolean',
        'pub_date' => 'integer',
        'unpub_date' => 'integer',
        'parent' => 'integer',
        'isfolder' => 'boolean',
        'richtext' => 'boolean',
        'template' => 'integer',
        'menuindex' => 'integer',
        'searchable' => 'boolean',
        'cacheable' => 'boolean',
        'createdby' => 'integer',
        'editedby' => 'integer',
        'deleted' => 'boolean',
        'deletedby' => 'integer',
        'publishedon' => 'integer',
        'publishedby' => 'integer',
        'donthit' => 'boolean',
        'privateweb' => 'boolean',
        'privatemgr' => 'boolean',
        'content_dispo' => 'integer',
        'hidemenu' => 'boolean',
        'content_type' => 'integer',
        'uri_override' => 'boolean',
        'hide_children_in_tree' => 'boolean',
        'show_in_tree' => 'boolean',
        'properties' => 'array',
        'alias_visible' => 'boolean',
    ];

    protected $attributes = [
        'type' => 'document',
        'contentType' => 'text/html',
        'alias_visible' => 1,
    ];

    // -------------------------------------------------------------------------
    // Boot
    // -------------------------------------------------------------------------

    protected static function booted(): void
    {
        static::addGlobalScope('not_deleted', fn($query) => $query->where('deleted', 0));
    }

    public static function withDeleted()
    {
        return static::withoutGlobalScope('not_deleted');
    }

    public static function onlyDeleted()
    {
        return static::withoutGlobalScope('not_deleted')->where('deleted', 1);
    }

    // -------------------------------------------------------------------------
    // Accessors
    // -------------------------------------------------------------------------

    protected function uri(): Attribute
    {
        return Attribute::make(
            get: fn($value) => $value === 'index' ? '' : ($value ?? ''),
        );
    }

    // -------------------------------------------------------------------------
    // Relations
    // -------------------------------------------------------------------------

     public function blocks()
     {
         return $this->hasMany(PbBlockData::class, 'model_id', 'id')
             ->where('model_type', $this->class_key)
             ->whereNotNull('published_at')
             ->where('published_at', '<=', now())
             ->whereNull('deleted_at')
             ->orderBy('menuindex');
     }

    public function parentResource()
    {
        return $this->belongsTo(self::class, 'parent', 'id'); 
    }

    public function children()
    {
        return $this->hasMany(self::class, 'parent', 'id');
    }

    public function templateResource()
    {
        return $this->belongsTo(Template::class, 'template', 'id');
    }

    public function context()
    {
        return $this->belongsTo(Context::class, 'context_key', 'key');
    }

    // -------------------------------------------------------------------------
    // TV variables
    // -------------------------------------------------------------------------
    protected array $tvCache = [];
    protected bool $tvCacheLoaded = false;

    protected function loadTvCache(): void
    {
        if ($this->tvCacheLoaded) {
            return;
        }

        $rows = query('site_tmplvar_contentvalues')
            ->join('site_tmplvars', 'site_tmplvars.id', '=', 'site_tmplvar_contentvalues.tmplvarid')
            ->where('site_tmplvar_contentvalues.contentid', $this->id)
            ->select('site_tmplvars.name', 'site_tmplvar_contentvalues.value')
            ->get();

        foreach ($rows as $row) {
            $this->tvCache[$row->name] = $row->value;
        }

        $this->tvCacheLoaded = true;
    }

    public function tv(string $name, mixed $default = null): mixed
    {
        $this->loadTvCache();

        return $this->tvCache[$name] ?? $default;
    }

    // -------------------------------------------------------------------------
    // Scopes
    // -------------------------------------------------------------------------

    public function scopeVisible($query)
    {
        return $query->where('hidemenu', 0);
    }

    public function scopePublished($query)
    {
        return $query->where('published', true);
    }

    public function scopeSearch($query, $search)
    {
        return $query->where(function($q) use ($search) {
            $q->where('pagetitle', 'LIKE', "%{$search}%")
                ->orWhere('longtitle', 'LIKE', "%{$search}%")
                ->orWhere('description', 'LIKE', "%{$search}%")
                ->orWhere('content', 'LIKE', "%{$search}%");
        });
    }

    // -------------------------------------------------------------------------
    // Helpers
    // -------------------------------------------------------------------------

    public function isFolder()
    {
        return (bool) $this->isfolder;
    }

    public function isPublished()
    {
        if (!$this->published || $this->deleted) {
            return false;
        }

        $now = time();

        if ($this->pub_date && $this->pub_date > $now) {
            return false;
        }

        if ($this->unpub_date && $this->unpub_date < $now) {
            return false;
        }

        return true;
    }

    public function getBreadcrumbs()
    {
        $breadcrumbs = [];
        $resource = $this;

        while ($resource && $resource->id > 0) {
            array_unshift($breadcrumbs, [
                'id' => $resource->id,
                'pagetitle' => $resource->pagetitle,
                'menutitle' => $resource->menutitle ?: $resource->pagetitle,
                'alias' => $resource->alias,
                'uri' => $resource->uri,
            ]);
            $resource = $resource->parentResource;
        }

        return $breadcrumbs;
    }

    public static function getMenu($parentId = 0, $maxDepth = 0, $currentId = null)
    {
        $resources = self::visible()
            ->published()
            ->orderBy('parent')
            ->orderBy('menuindex')
            ->get();

        $grouped = [];
        foreach ($resources as $resource) {
            $grouped[$resource->parent][] = $resource;
        }

        $ancestorIds = $currentId ? self::getAncestorIds($grouped, $currentId) : [];

        return self::buildTree($grouped, $parentId, $maxDepth, 1, $currentId, $ancestorIds);
    }

    private static function getAncestorIds(array $grouped, int $currentId): array
    {
        $parentMap = [];
        foreach ($grouped as $items) {
            foreach ($items as $resource) {
                $parentMap[$resource->id] = $resource->parent;
            }
        }

        $ancestors = [];
        $id = $parentMap[$currentId] ?? null;

        while ($id && $id > 0) {
            $ancestors[] = $id;
            $id = $parentMap[$id] ?? null;
        }

        return $ancestors;
    }

    private static function buildTree(
        array $grouped,
        int $parentId,
        int $maxDepth,
        int $currentDepth,
        ?int $currentId,
        array $ancestorIds
    ): array {
        if ($maxDepth > 0 && $currentDepth > $maxDepth) {
            return [];
        }

        if (!isset($grouped[$parentId])) {
            return [];
        }

        $menu = [];

        foreach ($grouped[$parentId] as $resource) {
            $isActive = $currentId !== null && $currentId === $resource->id;

            $item = [
                'id'          => $resource->id,
                'class_key'   => $resource->class_key,
                'title'       => $resource->menutitle ?: $resource->pagetitle,
                'pagetitle'   => $resource->pagetitle,
                'alias'       => $resource->alias,
                'uri'         => $resource->uri ?: $resource->alias,
                'attributes'  => $resource->link_attributes,
                'description' => $resource->description,
                'isfolder'    => $resource->isfolder,
                'menuindex'   => $resource->menuindex,
                'active'      => $isActive,
                'is_ancestor' => in_array($resource->id, $ancestorIds, true),
                'level'       => $currentDepth,
                'content'     => '',
                'children'    => [],
            ];

            if ($resource->class_key === 'MODX\Revolution\modWebLink') {
                $item['content'] = is_numeric($resource->content)
                    ? modx()->makeUrl((int) $resource->content)
                    : $resource->content;
            }

            $children = self::buildTree(
                $grouped,
                $resource->id,
                $maxDepth,
                $currentDepth + 1,
                $currentId,
                $ancestorIds
            );

            if (!empty($children)) {
                $item['children']         = $children;
                $item['has_active_child'] = self::hasActiveChild($children);
            }

            $menu[] = $item;
        }

        return $menu;
    }

    private static function hasActiveChild(array $children): bool
    {
        foreach ($children as $child) {
            if ($child['active']) {
                return true;
            }
            if (!empty($child['children']) && self::hasActiveChild($child['children'])) {
                return true;
            }
        }
        return false;
    }
}