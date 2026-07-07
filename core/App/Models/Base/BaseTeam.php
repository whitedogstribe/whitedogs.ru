<?php

// THIS FILE IS AUTO-GENERATED. DO NOT EDIT.
// Edit Team.php instead.

namespace PageBlocks\App\Models\Base;

use Boshnik\PageBlocks\Models\AbstractDataModel;

abstract class BaseTeam extends AbstractDataModel
{
    protected $table = 'team';

    protected $fillable = [
        'model_type',
        'model_id',
        'context_key',
        'constructor_id',
        'menuindex',
        'published_at',
        'data',
        'name',
        'position',
        'alias',
        'avatar',
        'group',
        'seo_title',
        'seo_description',
        'description',
        'content',
    ];

    protected $casts = [
        'menuindex' => 'int',
        'published_at' => 'datetime',
        'data' => 'array',
    ];

    protected $attributes = [
        'context_key' => 'web',
        'menuindex' => 0,
        'group' => 'instructor',
    ];
}