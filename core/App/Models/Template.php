<?php
namespace PageBlocks\App\Models;

use Illuminate\Database\Eloquent\Model;

class Template extends Model
{
    protected $table = 'site_templates';
    protected $primaryKey = 'id';
    public $timestamps = false;

    protected $fillable = [
        'templatename', 'description', 'editor_type', 'category',
        'icon', 'template_type', 'content', 'locked', 'properties',
        'static', 'static_file'
    ];

    protected $casts = [
        'id' => 'integer',
        'editor_type' => 'integer',
        'category' => 'integer',
        'template_type' => 'integer',
        'locked' => 'boolean',
        'properties' => 'array',
        'static' => 'boolean',
    ];

    public function resources()
    {
        return $this->hasMany(Resource::class, 'template', 'id');
    }
}