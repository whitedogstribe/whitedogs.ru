<?php

return [
    'superadmin' => function (array $params, $content) {
        if ($this->modx->user->id === 1) {
            return $content;
        }
    }
];