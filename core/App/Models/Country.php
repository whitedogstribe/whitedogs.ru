<?php

namespace PageBlocks\App\Models;

use PageBlocks\App\Models\Base\BaseCountry;

class Country extends BaseCountry
{
    // Ваши кастомные методы, relations, scopes — здесь
    // Этот файл не будет перезаписан при изменениях схемы

    protected array $copiableRelations = [];
}