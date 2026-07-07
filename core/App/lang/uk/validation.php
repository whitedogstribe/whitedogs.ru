<?php

return [
    'error_failed'        => 'Валідація не пройшла.',
    'error_missing'       => 'Поле :attribute відсутнє.',
    'error_csrf'          => 'Несумісність CSRF токена.',
    'error_recaptcha'     => 'Помилка перевірки reCAPTCHA. Спробуйте ще раз.',

    // Boolean
    'error_accepted'      => 'Поле :attribute має бути прийняте.',
    'error_accepted_if'   => 'Поле :attribute має бути прийняте, коли :other дорівнює :value.',
    'error_boolean'       => 'Поле :attribute має бути логічного типу.',
    'error_declined'      => 'Поле :attribute має бути відхилене.',
    'error_declined_if'   => 'Поле :attribute має бути відхилене, коли :other дорівнює :value.',

    // String
    'error_alpha'          => 'Поле :attribute може містити лише літери.',
    'error_alpha_num'      => 'Поле :attribute може містити лише літери та цифри.',
    'error_alpha_dash'     => 'Поле :attribute може містити лише літери, цифри, дефіси та підкреслення.',
    'error_regex'          => 'Поле :attribute має неправильний формат.',
    'error_string'         => 'Поле :attribute має бути непорожнім рядком.',
    'error_email'          => 'Поле :attribute має бути дійсною email адресою.',
    'error_confirmed'      => 'Підтвердження для :attribute не збігається з :other.',
    'error_different'      => 'Поле :attribute має відрізнятися від :other.',
    'error_same'           => 'Поле :attribute має збігатися з :other.',
    'error_in'             => 'Поле :attribute має бути одним з наступних: :types.',
    'error_not_in'         => 'Поле :attribute не повинно бути одним з наступних: :types.',
    'error_json'           => 'Поле :attribute має бути коректним JSON рядком.',
    'error_lowercase'      => 'Поле :attribute має бути в нижньому регістрі.',
    'error_uppercase'      => 'Поле :attribute має бути у верхньому регістрі.',
    'error_min_length'     => 'Поле :attribute має містити щонайменше :count символів.',
    'error_max_length'     => 'Поле :attribute не повинно перевищувати :count символів.',
    'error_url'            => 'Поле :attribute має бути коректним URL.',
    'error_uuid'           => 'Поле :attribute має бути коректним UUID.',
    'error_min_string'     => 'Поле :attribute має містити не менше :count символів.',
    'error_max_string'     => 'Поле :attribute не повинно перевищувати :count символів.',
    'error_size_string'    => 'Поле :attribute має містити рівно :count символів.',
    'error_between_string' => 'Поле :attribute має містити від :min до :max символів.',

    // Numbers
    'error_numeric'         => 'Поле :attribute має бути числом.',
    'error_integer'         => 'Поле :attribute має бути цілим числом.',
    'error_decimal'         => 'Поле :attribute має містити від :min до :max знаків після коми.',
    'error_gt'              => 'Поле :attribute має бути більше ніж :other.',
    'error_gte'             => 'Поле :attribute має бути більшим або дорівнювати :other.',
    'error_lt'              => 'Поле :attribute має бути менше ніж :other.',
    'error_lte'             => 'Поле :attribute має бути менше або дорівнювати :other.',
    'error_min_digits'      => 'Поле :attribute має містити щонайменше :count цифр.',
    'error_max_digits'      => 'Поле :attribute має містити не більше :count цифр.',
    'error_min_numeric'     => 'Поле :attribute має бути щонайменше :count.',
    'error_max_numeric'     => 'Поле :attribute не повинно перевищувати :count.',
    'error_size_numeric'    => 'Поле :attribute має дорівнювати :count.',
    'error_between_numeric' => 'Поле :attribute має бути між :min та :max.',

    // Arrays
    'error_array'         => 'Поле :attribute має бути масивом.',
    'error_contains'      => 'Поле :attribute має містити хоча б один з наступних елементів: :types.',
    'error_distinct'      => 'Поле :attribute містить повторювані значення.',
    'error_in_array'      => 'Поле :attribute має існувати в :other.',
    'error_min_array'     => 'Поле :attribute має містити щонайменше :count елементів.',
    'error_max_array'     => 'Поле :attribute не повинно містити більше :count елементів.',
    'error_size_array'    => 'Поле :attribute має містити рівно :count елементів.',
    'error_between_array' => 'Поле :attribute має містити від :min до :max елементів.',

    // Dates
    'error_date'               => 'Поле :attribute не є коректною датою.',
    'error_date_equals'        => 'Поле :attribute має дорівнювати даті :other.',
    'error_date_format'        => 'Поле :attribute не відповідає формату: :types.',
    'error_before'             => 'Поле :attribute має бути датою до :other.',
    'error_before_or_equal'    => 'Поле :attribute має бути датою до або дорівнювати :other.',
    'error_after'              => 'Поле :attribute має бути датою після :other.',
    'error_after_or_equal'     => 'Поле :attribute має бути датою після або дорівнювати :other.',

    // Files
    'error_file'         => 'Поле :attribute має бути файлом.',
    'error_image'        => 'Поле :attribute має бути зображенням.',
    'error_mimes'        => 'Файл :attribute має бути одного з типів: :types.',
    'error_extensions'   => 'Файл :attribute має мати одне з розширень: :types.',
    'error_dimensions'   => 'Зображення :attribute має некоректні розміри.',
    'error_min_file'     => 'Файл :attribute має важити щонайменше :count кілобайт.',
    'error_max_file'     => 'Файл :attribute не повинен перевищувати :count кілобайт.',
    'error_size_file'    => 'Файл :attribute має важити :count кілобайт.',
    'error_between_file' => 'Файл :attribute має важити від :min до :max кілобайт.',

    // File list
    'error_min_files'     => 'Поле :attribute має містити щонайменше :count файлів.',
    'error_max_files'     => 'Поле :attribute не повинно містити більше :count файлів.',
    'error_size_files'    => 'Поле :attribute має містити рівно :count файлів.',
    'error_between_files' => 'Поле :attribute має містити від :min до :max файлів.',

    // Database
    'error_unique' => 'Поле :attribute вже зайняте.',
    'error_exists' => 'Поле :attribute вже існує в базі даних.',

    // Utilities
    'error_required'     => 'Поле :attribute є обовʼязковим.',
    'error_required_if'  => 'Поле :attribute є обовʼязковим, коли :other дорівнює :value.',
    'error_filled'       => 'Поле :attribute не повинно бути порожнім.',
    'error_nullable'     => 'Поле :attribute може бути null.',
    'error_empty'        => 'Поле :attribute має бути порожнім.',
];