<?php

namespace PageBlocks\App\Http\Middleware;

use Boshnik\PageBlocks\Http\Request;

abstract class Middleware
{
    public \modX $modx;
    public function __construct() {
        $this->modx = modx();
    }

    abstract public function handle(Request $request);
}