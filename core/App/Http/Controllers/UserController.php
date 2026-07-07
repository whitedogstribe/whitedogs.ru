<?php

namespace PageBlocks\App\Http\Controllers;

use Boshnik\PageBlocks\Http\Controllers\DataController;
use Boshnik\PageBlocks\Http\Request;
use PageBlocks\App\Models\User;

class UserController extends DataController
{
    protected string $table = 'users';
    protected string $model = User::class;

    public function rules(array $data, ?int $id = null): array
    {
        return [];
    }
}