<?php

namespace PageBlocks\App\Http\Middleware;

use Boshnik\PageBlocks\Http\Request;

class VerifyGoogleRecaptchaV3 extends Middleware
{
    public function handle(Request $request)
    {
        $secretKey = config('pageblocks_recaptcha_secret_key');
        if (empty($secretKey)) {
            return true;
        }

        if (
            in_array($request->method(), ['POST', 'PUT', 'PATCH', 'DELETE'], true) &&
            !$this->verifyRecaptcha($request, $secretKey)
        ) {
            return response()->recaptchaError();
        }

        return true;
    }

    protected function verifyRecaptcha(Request $request, string $secretKey): bool
    {
        $publicKey = $request->get('g-recaptcha-response');
        if (empty($publicKey)) {
            return false;
        }

        $response = http_post('https://www.google.com/recaptcha/api/siteverify', [
            'secret'   => $secretKey,
            'response' => $publicKey,
            'remoteip' => $request->ip(),
        ]);

        if (!empty($response['error'])) {
            console($response['error']);
            return false;
        }

        $result = $response['data'];

        return isset($result['success']) && $result['success'] === true && $result['score'] >= 0.5;
    }
}