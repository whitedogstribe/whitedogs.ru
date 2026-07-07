<?php

use Boshnik\PageBlocks\Facades\Route;
use Boshnik\PageBlocks\Facades\View;
use Boshnik\PageBlocks\Facades\Validator;
use Boshnik\PageBlocks\Http\Request;
use Boshnik\PageBlocks\Http\Response;
use Boshnik\PageBlocks\Routing\Redirect;
use Boshnik\PageBlocks\Support\Cache;
use Boshnik\PageBlocks\Support\Config;
use Boshnik\PageBlocks\Support\Lang;
use Boshnik\PageBlocks\Support\Arr;
use Boshnik\PageBlocks\Support\Log;

if (!function_exists('modx')) {
    function modx(): ?\modX
    {
        global $modx;

        if ($modx instanceof \modX) {
            return $modx;
        }

        if (class_exists(\modX::class) && method_exists(\modX::class, 'getInstance')) {
            return \modX::getInstance();
        }

        return null;
    }
}

if (!function_exists('lexicon')) {
    function lexicon($key, $namespace = ''): string
    {
        if (!in_array($namespace, ['core', '', null], true)) {
            modx()->lexicon->load($namespace . ':default');
        }
        return modx()->lexicon($key);
    }
}


if (!function_exists('csrf')) {
    function csrf(): string
    {
        return '<input type="hidden" name="_token" value="'.($_SESSION['_csrf_token'] ?? '').'">';
    }
}

if (!function_exists('query')) {
    function query($table = null)
    {
        $connection = \DB::connection();

        if ($table === null) {
            return $connection;
        }

        $builder = new \Boshnik\PageBlocks\Database\pbBuilder(
            $connection,
            $connection->getQueryGrammar(),
            $connection->getPostProcessor()
        );

        return $builder->from($table);
    }
}

if (!function_exists('model')) {
    function model(string $modelClass)
    {
        $model = 'PageBlocks\App\Models\\' . $modelClass;
        return $model::query();
    }
}

if (!function_exists('config')) {
    function config(string $key, $default = null) {
        return Config::get($key) ?? modx()->getOption($key, null, $default);
    }
}

if (!function_exists('request')) {
    function request(string $key = '')
    {
        $request = Request::getInstance();

        return empty($key) ? $request : $request->get($key);
    }
}

if (!function_exists('uri')) {
    function uri()
    {
        static $cached = null;
        if ($cached !== null) {
            return $cached;
        }

        $requestUri = $_SERVER['REQUEST_URI'] ?? '/';
        $path = parse_url($requestUri, PHP_URL_PATH) ?: '/';
        $path = preg_replace('#^/?index\.php/?#', '', $path);
        $path = trim($path, '/');
        $path = str_replace('.html', '', $path);

        return $cached = $path;
    }
}

if (!function_exists('alias')) {
    function alias()
    {
        $uri = uri();
        $context = context();
        if ($context) {
            $uri = preg_replace("#^/?$context/?#", '', $uri);
        }

        $segments = array_filter(explode('/', trim($uri, '/')));
        return end($segments) ?: '';
    }
}

if (!function_exists('context')) {
    function context()
    {
        $defaultContext = config('default_context', 'web');
        $uri = uri();
        if ($uri === '') {
            return $defaultContext;
        }

        $parts = explode('/', $uri);
        $context = $parts[0] ?? null;

        if (!$context || !preg_match('/^[a-z]{2}$/', $context)) {
            return $defaultContext;
        }

        $contextsJson = config('pageblocks_contexts', '{}');
        $contexts = json_decode($contextsJson, true) ?: [];

        $found = Arr::first($contexts, fn($v) => isset($v['key']) && $v['key'] === $context);

        return $found ? $context : null;
    }
}

if (!function_exists('cache')) {
    function cache(string $key, $value = null, int $ttl = 3600) {
        if (is_null($value)) {
            return Cache::get($key);
        }

        return Cache::set($key, $value, $ttl);
    }
}

if (!function_exists('response')) {
    function response($content = '', int $status = 200, array $headers = []): Response
    {
        $response = new Response();

        if ($content !== '') {
            if (is_array($content)) {
                $response->json($content, $status, $headers);
            } elseif (is_object($content)) {
                $response->object($content, $status, $headers);
            } else {
                $response->text((string)$content, $status, $headers);
            }
        }

        return $response;
    }
}

if (!function_exists('validate')) {
    function validate(...$args)
    {
        return Validator::make(...$args);
    }
}

if (!function_exists('view')) {
    function view(string $template, array $params = [], callable $callback = null): string
    {
        return View::make($template, $params, $callback);
    }
}

if (!function_exists('redirect')) {
    function redirect(...$args)
    {
        if (empty($args)) {
            return Redirect::getInstance();
        }

        return response()->redirect(...$args);
    }
}

if (!function_exists('route')) {
    function route(string $name, array $parameters = []): string
    {
        return Route::route($name, $parameters);
    }
}

if (!function_exists('lang')) {
    function lang(string $key, array $replace = [], string $locale = ''): string
    {
        return Lang::get($key, $replace, $locale);
    }
}

if (!function_exists('auth')) {
    function auth(string $context = '')
    {
        $modx = modx();
        return $modx->user
            ? $modx->user->isAuthenticated($context ?: $modx->context->key)
            : false;
    }
}

if (!function_exists('abort')) {
    function abort(int $code = 404, string $text = ''): Response
    {
        return response()->abort($code, $text)->send();
    }
}

if (!function_exists('console')) {
    function console($message, $array = [])
    {
        if ($array) {
            Log::error($message . PHP_EOL . print_r($array, true));
        } else {
            Log::error($message);
        }

    }
}

if (!function_exists('dd')) {
    function dd($message, $array = [])
    {
        if ($array) {
            Log::error($message . PHP_EOL . print_r($array, true));
        } else {
            Log::error($message);
        }
    }
}

if (!function_exists('now')) {
    function now(string $timezone = null): \Carbon\Carbon
    {
        return \Carbon\Carbon::now($timezone);
    }
}

if (!function_exists('http_post')) {
    function http_post(string $url, $data = null, array $headers = [], int $timeout = 10): array
    {
        $ch = curl_init();

        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_TIMEOUT, $timeout);
        curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, true);

        if (is_array($data)) {
            $data = http_build_query($data);
            $headers[] = 'Content-Type: application/x-www-form-urlencoded';
        }

        if ($data !== null) {
            curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
        }

        $headers[] = 'User-Agent: PageBlocksHttpClient/2.8.5';
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);

        $response = curl_exec($ch);
        $status = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        $error = curl_error($ch);

        curl_close($ch);

        $jsonData = [];
        if ($response && $status === 200) {
            $decoded = json_decode($response, true);
            if (json_last_error() === JSON_ERROR_NONE) {
                $jsonData = $decoded;
            }
        }

        return [
            'status' => $status,
            'body' => $response ?: '',
            'data' => $jsonData,
            'error' => $error ?: null,
        ];
    }
}