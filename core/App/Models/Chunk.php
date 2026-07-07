<?php
namespace PageBlocks\App\Models;

use Illuminate\Database\Eloquent\Model;

class Chunk extends Model
{
    protected $table = 'site_htmlsnippets';
    protected $primaryKey = 'id';
    public $timestamps = false;

    protected $fillable = [
        'name', 'description', 'editor_type', 'category',
        'cache_type', 'snippet', 'locked', 'properties',
        'static', 'static_file'
    ];

    protected $casts = [
        'id' => 'integer',
        'editor_type' => 'integer',
        'category' => 'integer',
        'cache_type' => 'boolean',
        'locked' => 'boolean',
        'properties' => 'array',
        'static' => 'boolean',
    ];

    public function category()
    {
        return $this->belongsTo(Category::class, 'category', 'id');
    }
}