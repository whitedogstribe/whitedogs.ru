<?php
namespace PageBlocks\App\Models;

use Illuminate\Database\Eloquent\Model;

/**
 * @property string $text
 * @property string $parent
 * @property string $action
 * @property string $description
 * @property string $icon
 * @property int $menuindex
 * @property string $params
 * @property string $handler
 * @property array|null $permissions
 * @property string $namespace
 */
class Menu extends Model
{
    protected $table = 'menus';
    protected $primaryKey = 'text';
    public $incrementing = false;
    protected $keyType = 'string';
    public $timestamps = false;

    protected $fillable = [
        'text',
        'parent',
        'action',
        'description',
        'icon',
        'menuindex',
        'params',
        'handler',
        'permissions',
        'namespace',
    ];

    protected $casts = [
        'menuindex' => 'integer',
        'permissions' => 'array',
    ];

    protected $attributes = [
        'namespace' => 'core',
        'menuindex' => 0,
    ];

    public function parent()
    {
        return $this->belongsTo(self::class, 'parent', 'text');
    }

    public function children()
    {
        return $this->hasMany(self::class, 'parent', 'text');
    }

    public function namespace()
    {
        return $this->belongsTo(Namespaces::class, 'namespace', 'name');
    }
}