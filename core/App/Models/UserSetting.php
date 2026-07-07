<?php
namespace PageBlocks\App\Models;

use Illuminate\Database\Eloquent\Model;
use PageBlocks\App\Models\User;

class UserSetting extends Model
{
    protected $table = 'user_settings';
    public $incrementing = false;
    public $timestamps = false;
    protected $primaryKey = ['user', 'key'];

    protected $fillable = [
        'user', 'key', 'value', 'xtype', 'namespace', 'area', 'editedon'
    ];

    protected $casts = [
        'user' => 'integer',
        'editedon' => 'integer',
    ];

    public function user()
    {
        return $this->belongsTo(User::class, 'user', 'id');
    }

    protected function setKeysForSaveQuery($query)
    {
        return $query->where('user', $this->getAttribute('user'))
            ->where('key', $this->getAttribute('key'));
    }
}