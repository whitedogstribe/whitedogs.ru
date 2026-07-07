<?php
namespace PageBlocks\App\Models;

use Illuminate\Database\Eloquent\Model;

class Session extends Model
{
    protected $table = 'session';
    protected $primaryKey = 'id';
    public $incrementing = false;
    protected $keyType = 'string';
    public $timestamps = false;

    protected $fillable = [
        'id', 'access', 'data'
    ];

    protected $casts = [
        'access' => 'integer',
    ];

    public function scopeActive($query, $threshold = 900)
    {
        return $query->where('access', '>=', time() - $threshold);
    }
}