<?php
namespace PageBlocks\App\Models;

use Illuminate\Database\Eloquent\Model;

class ContextSetting extends Model
{
    protected $table = 'context_setting';
    public $incrementing = false;
    public $timestamps = false;
    protected $primaryKey = ['context_key', 'key'];

    protected $fillable = [
        'context_key', 'key', 'value', 'xtype', 'namespace', 'area', 'editedon'
    ];

    protected $casts = [
        'editedon' => 'integer',
    ];

    public function context()
    {
        return $this->belongsTo(Context::class, 'context_key', 'key');
    }
}