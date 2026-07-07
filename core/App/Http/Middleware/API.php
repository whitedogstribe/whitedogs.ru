<?php

namespace PageBlocks\App\Http\Middleware;

use Boshnik\PageBlocks\Http\Request;

class API extends Middleware
{
    public function handle(Request $request)
    {
        if (strpos($request->path(), '/api/') !== 0) {
            abort(403);
        }

        $authHeader = $request->header('Authorization');

        if (!$authHeader || !preg_match('/^Bearer\s+(\S+)$/', $authHeader, $matches)) {
            return response()->error('Missing or invalid Authorization header');
        }

        $token = $matches[1];

        if (!$this->isValidToken($token)) {
            return response()->error('Invalid API token');
        }

        return true;
    }

    protected function isValidToken(string $token): bool
    {
        $validTokens = ['secret123', 'myapitoken'];
        return in_array($token, $validTokens, true);
    }
}