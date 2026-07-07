<?php
namespace PageBlocks\App\Models;

use Illuminate\Database\Eloquent\Model;

/**
 * Class modUser
 *
 * @property int $id
 * @property string $username
 * @property string $password
 * @property string $cachepwd
 * @property string $class_key
 * @property int $active
 * @property int $remote_key
 * @property string $remote_data
 * @property string $hash_class
 * @property string $salt
 * @property int $primary_group
 * @property string $session_stale
 * @property string $sudo
 * @property int $createdon
 */
class User extends Model
{
    protected $table = 'users';
    protected $primaryKey = 'id';
    public $timestamps = false;

    protected $fillable = [
        'username',
        'password',
        'cachepwd',
        'class_key',
        'active',
        'remote_key',
        'remote_data',
        'hash_class',
        'salt',
        'primary_group',
        'session_stale',
        'sudo',
        'createdon',
    ];

    protected $hidden = [
        'password',
        'cachepwd',
        'salt',
        'remote_key',
        'remote_data',
    ];

    protected $casts = [
        'id' => 'integer',
        'active' => 'boolean',
        'remote_key' => 'integer',
        'primary_group' => 'integer',
        'sudo' => 'boolean',
        'createdon' => 'integer',
    ];

    protected $attributes = [
        'class_key' => 'modUser',
        'active' => 1,
        'sudo' => 0,
        'hash_class' => 'hashing.modNative',
    ];


    public function profile()
    {
        return $this->hasOne(UserProfile::class, 'internalKey', 'id');
    }

    public function primaryGroup()
    {
        return $this->belongsTo(UserGroup::class, 'primary_group', 'id');
    }

    public function userGroups()
    {
        return $this->belongsToMany(
            UserGroup::class,
            'member_groups',
            'member',
            'user_group'
        )->withPivot('role', 'rank');
    }


    public function groupMemberships()
    {
        return $this->hasMany(UserGroupMember::class, 'member', 'id');
    }


    public function settings()
    {
        return $this->hasMany(UserSetting::class, 'user', 'id');
    }

    public function createdResources()
    {
        return $this->hasMany(Resource::class, 'createdby', 'id');
    }

    public function sessions()
    {
        return $this->hasMany(Session::class, 'userid', 'id');
    }

    public function scopeActive($query)
    {
        return $query->where('active', 1);
    }

    public function scopeInactive($query)
    {
        return $query->where('active', 0);
    }

    public function scopeSudo($query)
    {
        return $query->where('sudo', 1);
    }

    public function scopeSearchByUsername($query, $username)
    {
        return $query->where('username', 'LIKE', "%{$username}%");
    }

    public function scopeSearchByEmail($query, $email)
    {
        return $query->whereHas('profile', function($q) use ($email) {
            $q->where('email', 'LIKE', "%{$email}%");
        });
    }

    public function scopeInGroup($query, $groupId)
    {
        return $query->whereHas('userGroups', function($q) use ($groupId) {
            $q->where('user_group', $groupId);
        });
    }

    public function scopeWithRole($query, $roleId)
    {
        return $query->whereHas('groupMemberships', function($q) use ($roleId) {
            $q->where('role', $roleId);
        });
    }

    public function setPassword($password)
    {
        $this->salt = bin2hex(random_bytes(16));

        $this->password = password_hash($password . $this->salt, PASSWORD_DEFAULT);

        return $this->save();
    }

    public function isActive()
    {
        return (bool) $this->active;
    }

    public function hasAdmin()
    {
        return (bool) $this->sudo;
    }

    public function getEmail()
    {
        return $this->profile ? $this->profile->email : null;
    }

    public function getFullName()
    {
        if (!$this->profile) {
            return $this->username;
        }

        $parts = array_filter([
            $this->profile->fullname,
        ]);

        return !empty($parts) ? implode(' ', $parts) : $this->username;
    }

    public function isMemberOf($groupId)
    {
        return $this->userGroups()->where('user_group', $groupId)->exists();
    }

    public function hasRoleInGroup($groupId, $roleId)
    {
        return $this->groupMemberships()
            ->where('user_group', $groupId)
            ->where('role', $roleId)
            ->exists();
    }

    public function getRoles()
    {
        return $this->groupMemberships()
            ->with('role')
            ->get()
            ->pluck('role')
            ->unique('id');
    }

    public function getSetting($key, $default = null)
    {
        $setting = $this->settings()
            ->where('key', $key)
            ->first();

        return $setting ? $setting->value : $default;
    }


    public function setSetting($key, $value)
    {
        return UserSetting::updateOrCreate(
            [
                'user' => $this->id,
                'key' => $key,
            ],
            [
                'value' => $value,
            ]
        );
    }

    public function getLastActivity()
    {
        $session = $this->sessions()
            ->orderBy('access', 'desc')
            ->first();

        return $session ? $session->access : null;
    }

    public function isOnline($threshold = 900)
    {
        $lastActivity = $this->getLastActivity();

        if (!$lastActivity) {
            return false;
        }

        return (time() - $lastActivity) <= $threshold;
    }

    public function activate()
    {
        $this->active = 1;
        return $this->save();
    }

    public function addToGroup($groupId, $roleId = 1, $rank = 0)
    {
        return UserGroupMember::firstOrCreate([
            'user_group' => $groupId,
            'member' => $this->id,
        ], [
            'role' => $roleId,
            'rank' => $rank,
        ]);
    }

    public function removeFromGroup($groupId)
    {
        return UserGroupMember::where('user_group', $groupId)
            ->where('member', $this->id)
            ->delete();
    }
}