<?php

namespace PageBlocks\App\Services;

class Service
{
    public \modX $modx;

    public function __construct(\modX $modx)
    {
        $this->modx = $modx;
    }
}