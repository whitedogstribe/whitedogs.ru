<?php
namespace PageBlocks\App\Models;

use Illuminate\Database\Eloquent\Model;
use PageBlocks\App\Models\User;

class UserProfile extends Model
{
    protected $table = 'user_attributes';
    protected $primaryKey = 'id';
    public $timestamps = false;

    protected $fillable = [
        'internalKey', 'fullname', 'email', 'phone', 'mobilephone',
        'dob', 'gender', 'address', 'country', 'city', 'state',
        'zip', 'fax', 'photo', 'comment', 'website',
        'blocked', 'blockeduntil', 'blockedafter',
        'logincount', 'lastlogin', 'thislogin', 'failedlogincount',
        'sessionid', 'extended'
    ];

    protected $casts = [
        'internalKey' => 'integer',
        'dob' => 'integer',
        'gender' => 'integer',
        'blocked' => 'boolean',
        'blockeduntil' => 'integer',
        'blockedafter' => 'integer',
        'logincount' => 'integer',
        'lastlogin' => 'integer',
        'thislogin' => 'integer',
        'failedlogincount' => 'integer',
        'extended' => 'array',
    ];

    public function user()
    {
        return $this->belongsTo(User::class, 'internalKey', 'id');
    }

    public function isBlocked()
    {
        if (!$this->blocked) {
            return false;
        }

        $now = time();

        if ($this->blockeduntil && $this->blockeduntil < $now) {
            return false;
        }

        if ($this->blockedafter && $this->blockedafter > $now) {
            return false;
        }

        return true;
    }
}