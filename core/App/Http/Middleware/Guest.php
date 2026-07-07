<?php

namespace PageBlocks\App\Http\Middleware;

use Boshnik\PageBlocks\Http\Request;

class Guest extends Middleware
{
    public function handle(Request $request)
    {
        if (!$this->modx->user->isAuthenticated($this->modx->context->key)) {
            return true;
        }

        return redirect('/');
    }
}