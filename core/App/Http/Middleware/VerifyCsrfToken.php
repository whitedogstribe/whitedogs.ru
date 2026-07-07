<?php

namespace PageBlocks\App\Http\Middleware;

use Boshnik\PageBlocks\Http\Request;

class VerifyCsrfToken extends Middleware
{
    public function handle(Request $request)
    {
        if (
            in_array($request->method(), ['POST', 'PUT', 'PATCH', 'DELETE'], true) &&
            !$this->tokensMatch($request)
        ) {
            return response()->csrfError();
        }

        return true;
    }

    protected function tokensMatch(Request $request): bool
    {
        $token = $request->input('_token') ?: $request->header('X-CSRF-TOKEN');
        $session_token = $_SESSION['_csrf_token'];

        return isset($session_token) &&
            is_string($session_token) &&
            is_string($token) &&
            hash_equals($session_token, $token);
    }
}