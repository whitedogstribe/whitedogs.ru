<?php
namespace PageBlocks\App\Models;

use Illuminate\Database\Eloquent\Model;
use PageBlocks\App\Models\User;

class UserGroup extends Model
{
    protected $table = 'membergroup_names';
    protected $primaryKey = 'id';
    public $timestamps = false;

    protected $fillable = [
        'name', 'description', 'parent', 'rank', 'dashboard'
    ];

    protected $casts = [
        'id' => 'integer',
        'parent' => 'integer',
        'rank' => 'integer',
        'dashboard' => 'integer',
    ];

    public function users()
    {
        return $this->belongsToMany(
            User::class,
            'member_groups',
            'user_group',
            'member'
        )->withPivot('role', 'rank');
    }

    public function members()
    {
        return $this->hasMany(UserGroupMember::class, 'user_group', 'id');
    }

    public function parentGroup()
    {
        return $this->belongsTo(self::class, 'parent', 'id');
    }

    public function children()
    {
        return $this->hasMany(self::class, 'parent', 'id');
    }
}