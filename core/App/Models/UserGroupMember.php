<?php
namespace PageBlocks\App\Models;

use Illuminate\Database\Eloquent\Model;
use PageBlocks\App\Models\User;

class UserGroupMember extends Model
{
    protected $table = 'member_groups';
    protected $primaryKey = 'id';
    public $timestamps = false;

    protected $fillable = [
        'user_group', 'member', 'role', 'rank'
    ];

    protected $casts = [
        'id' => 'integer',
        'user_group' => 'integer',
        'member' => 'integer',
        'role' => 'integer',
        'rank' => 'integer',
    ];

    public function userGroup()
    {
        return $this->belongsTo(UserGroup::class, 'user_group', 'id');
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'member', 'id');
    }

    public function role()
    {
        return $this->belongsTo(UserGroupRole::class, 'role', 'id');
    }
}