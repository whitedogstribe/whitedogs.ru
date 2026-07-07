<?php
namespace PageBlocks\App\Models;

use Illuminate\Database\Eloquent\Model;

class SystemSetting extends Model
{
    protected $table = 'system_settings';
    protected $primaryKey = 'key';
    public $incrementing = false;
    protected $keyType = 'string';
    public $timestamps = false;

    protected $fillable = [
        'key', 'value', 'xtype', 'namespace', 'area', 'editedon'
    ];

    protected $casts = [
        'editedon' => 'integer',
    ];
}