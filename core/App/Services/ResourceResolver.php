<?php

namespace PageBlocks\App\Services;

use PageBlocks\App\Models\Resource;

/**
 * Resolves the current MODX resource by URI or alias.
 *
 * Extracted from ResourceController::__construct() to:
 *  - keep the controller free of bootstrap side-effects
 *  - make resolution logic independently testable
 */
class ResourceResolver
{
    public function resolve(string $uri, string $alias): ?Resource
    {
        if (empty($uri)) {
            return Resource::find(config('site_start'));
        }

        return Resource::where('uri', $uri)->first()
            ?? ($alias ? Resource::where('alias', $alias)->first() : null);
    }
}