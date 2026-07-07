<?php

namespace PageBlocks\App\Models;

use Illuminate\Database\Eloquent\Model;

class Namespaces extends Model
{
    protected $table = 'namespaces';
    protected $primaryKey = 'name';
    public $incrementing = false;
    protected $keyType = 'string';
    public $timestamps = false;

    protected $fillable = [
        'name',
        'path',
        'assets_path',
    ];

    public function menus()
    {
        return $this->hasMany(Menu::class, 'namespace', 'name');
    }
}