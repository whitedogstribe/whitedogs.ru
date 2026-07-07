<?php
namespace PageBlocks\App\Models;

use Illuminate\Database\Eloquent\Model;

class UserGroupRole extends Model
{
    protected $table = 'user_group_roles';
    protected $primaryKey = 'id';
    public $timestamps = false;

    protected $fillable = [
        'name', 'description', 'authority'
    ];

    protected $casts = [
        'id' => 'integer',
        'authority' => 'integer',
    ];

    public function members()
    {
        return $this->hasMany(UserGroupMember::class, 'role', 'id');
    }
}