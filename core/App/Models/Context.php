<?php
namespace PageBlocks\App\Models;

use Illuminate\Database\Eloquent\Model;

class Context extends Model
{
    protected $table = 'context';
    protected $primaryKey = 'key';
    public $incrementing = false;
    protected $keyType = 'string';
    public $timestamps = false;

    protected $fillable = [
        'key', 'name', 'description', 'rank'
    ];

    protected $casts = [
        'rank' => 'integer',
    ];

    public function resources()
    {
        return $this->hasMany(Resource::class, 'context_key', 'key');
    }

    public function settings()
    {
        return $this->hasMany(ContextSetting::class, 'context_key', 'key');
    }
}