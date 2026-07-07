<?php
namespace PageBlocks\App\Models;

use Illuminate\Database\Eloquent\Model;

class Plugin extends Model
{
    protected $table = 'site_plugins';
    protected $primaryKey = 'id';
    public $timestamps = false;

    protected $fillable = [
        'name', 'description', 'editor_type', 'category',
        'cache_type', 'plugincode', 'locked', 'properties',
        'disabled', 'moduleguid', 'static', 'static_file'
    ];

    protected $casts = [
        'id' => 'integer',
        'editor_type' => 'integer',
        'category' => 'integer',
        'cache_type' => 'boolean',
        'locked' => 'boolean',
        'properties' => 'array',
        'disabled' => 'boolean',
        'static' => 'boolean',
    ];

    public function category()
    {
        return $this->belongsTo(Category::class, 'category', 'id');
    }

    public function events()
    {
        return $this->belongsToMany(
            Event::class,
            'site_plugin_events',
            'pluginid',
            'event'
        )->withPivot('priority', 'propertyset');
    }
}