<?php
namespace PageBlocks\App\Models;

use Illuminate\Database\Eloquent\Model;

class Event extends Model
{
    protected $table = 'system_eventnames';
    protected $primaryKey = 'id';
    public $timestamps = false;

    protected $fillable = [
        'name', 'service', 'groupname'
    ];

    protected $casts = [
        'id' => 'integer',
        'service' => 'integer',
        'groupname' => 'string',
    ];

    public function plugins()
    {
        return $this->belongsToMany(
            Plugin::class,
            'site_plugin_events',
            'event',
            'pluginid'
        )->withPivot('priority', 'propertyset');
    }
}