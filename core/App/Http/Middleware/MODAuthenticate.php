<?php

namespace PageBlocks\App\Http\Middleware;

use Boshnik\PageBlocks\Http\Request;

class MODAuthenticate extends Middleware
{
    public function handle(Request $request)
    {
        $request->validate([
            'HTTP_MODAUTH' => 'required|string'
        ]);

        $userToken = $this->modx->user->getUserToken('mgr');
        if ($request->HTTP_MODAUTH !== $userToken) {
            return false;
        }

        if (!$this->modx->user->hasSessionContext('mgr')) {
            return false;
        }

        return true;
    }
}