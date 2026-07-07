<?php

// THIS FILE IS AUTO-GENERATED. DO NOT EDIT.
// Edit BlogPost.php instead.

namespace PageBlocks\App\Models\Base;

use Boshnik\PageBlocks\Models\AbstractDataModel;

abstract class BaseBlogPost extends AbstractDataModel
{
    protected $table = 'blog_posts';

    protected $fillable = [
        'model_type',
        'model_id',
        'context_key',
        'menuindex',
        'published_at',
        'data',
        'title',
        'alias',
        'description',
        'img',
        'content',
        'old_content',
        'author_id',
        'user_id',
        'views',
        'category',
        'tour_id',
        'seo_title',
        'preview',
        'video',
    ];

    protected $casts = [
        'menuindex' => 'int',
        'published_at' => 'datetime',
        'data' => 'array',
        'author_id' => 'int',
        'user_id' => 'int',
        'views' => 'int',
        'tour_id' => 'int',
    ];

    protected $attributes = [
        'context_key' => 'web',
        'menuindex' => 0,
        'author_id' => 0,
        'user_id' => 0,
        'views' => 0,
        'tour_id' => 0,
    ];
}