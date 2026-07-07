<?php

namespace PageBlocks\App\Http\Middleware;

use Boshnik\PageBlocks\Http\Request;

class Authenticate extends Middleware
{
    public function handle(Request $request)
    {
        if ($this->modx->user->isAuthenticated($this->modx->context->key)) {
            return true;
        }

        abort(401);
    }
}