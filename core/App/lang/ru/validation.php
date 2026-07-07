<?php

return [
    'error_failed'        => 'Проверка не пройдена.',
    'error_missing'       => 'Поле :attribute отсутствует.',
    'error_csrf'          => 'Несовпадение CSRF-токена.',
    'error_recaptcha'     => 'Ошибка проверки reCAPTCHA. Попробуйте еще раз.',

    // Boolean
    'error_accepted'      => 'Поле :attribute должно быть принято.',
    'error_accepted_if'   => 'Поле :attribute должно быть принято, если :other равно :value.',
    'error_boolean'       => 'Поле :attribute должно быть логическим значением.',
    'error_declined'      => 'Поле :attribute должно быть отклонено.',
    'error_declined_if'   => 'Поле :attribute должно быть отклонено, если :other равно :value.',

    // String
    'error_alpha'          => 'Поле :attribute может содержать только буквы.',
    'error_alpha_num'      => 'Поле :attribute может содержать только буквы и цифры.',
    'error_alpha_dash'     => 'Поле :attribute может содержать только буквы, цифры, дефисы и подчёркивания.',
    'error_regex'          => 'Поле :attribute имеет неверный формат.',
    'error_string'         => 'Поле :attribute должно быть непустой строкой.',
    'error_email'          => 'Поле :attribute должно быть действительным адресом электронной почты.',
    'error_confirmed'      => 'Подтверждение :attribute не совпадает с :other.',
    'error_different'      => 'Поле :attribute должно отличаться от :other.',
    'error_same'           => 'Поле :attribute должно совпадать с :other.',
    'error_in'             => 'Поле :attribute должно быть одним из следующих значений: :types.',
    'error_not_in'         => 'Поле :attribute не должно быть одним из следующих значений: :types.',
    'error_json'           => 'Поле :attribute должно быть корректной JSON-строкой.',
    'error_lowercase'      => 'Поле :attribute должно быть в нижнем регистре.',
    'error_uppercase'      => 'Поле :attribute должно быть в верхнем регистре.',
    'error_min_length'     => 'Поле :attribute должно содержать не менее :count символов.',
    'error_max_length'     => 'Поле :attribute не должно превышать :count символов.',
    'error_url'            => 'Поле :attribute должно быть корректным URL.',
    'error_uuid'           => 'Поле :attribute должно быть корректным UUID.',
    'error_min_string'     => 'Поле :attribute должно содержать не менее :count символов.',
    'error_max_string'     => 'Поле :attribute не должно превышать :count символов.',
    'error_size_string'    => 'Поле :attribute должно содержать ровно :count символов.',
    'error_between_string' => 'Поле :attribute должно содержать от :min до :max символов.',

    // Numbers
    'error_numeric'         => 'Поле :attribute должно быть числом.',
    'error_integer'         => 'Поле :attribute должно быть целым числом.',
    'error_decimal'         => 'Поле :attribute должно содержать от :min до :max знаков после запятой.',
    'error_gt'              => 'Поле :attribute должно быть больше чем :other.',
    'error_gte'             => 'Поле :attribute должно быть больше или равно :other.',
    'error_lt'              => 'Поле :attribute должно быть меньше чем :other.',
    'error_lte'             => 'Поле :attribute должно быть меньше или равно :other.',
    'error_min_digits'      => 'Поле :attribute должно содержать минимум :count цифр.',
    'error_max_digits'      => 'Поле :attribute должно содержать максимум :count цифр.',
    'error_min_numeric'     => 'Поле :attribute должно быть не меньше :count.',
    'error_max_numeric'     => 'Поле :attribute не должно превышать :count.',
    'error_size_numeric'    => 'Поле :attribute должно быть равно :count.',
    'error_between_numeric' => 'Поле :attribute должно быть между :min и :max.',

    // Arrays
    'error_array'         => 'Поле :attribute должно быть массивом.',
    'error_contains'      => 'Поле :attribute должно содержать хотя бы одно из следующих значений: :types.',
    'error_distinct'      => 'Поле :attribute содержит повторяющиеся значения.',
    'error_in_array'      => 'Поле :attribute должно существовать в :other.',
    'error_min_array'     => 'Поле :attribute должно содержать минимум :count элементов.',
    'error_max_array'     => 'Поле :attribute не должно содержать более :count элементов.',
    'error_size_array'    => 'Поле :attribute должно содержать ровно :count элементов.',
    'error_between_array' => 'Поле :attribute должно содержать от :min до :max элементов.',

    // Dates
    'error_date'               => 'Поле :attribute не является корректной датой.',
    'error_date_equals'        => 'Поле :attribute должно быть датой, равной :other.',
    'error_date_format'        => 'Поле :attribute не соответствует формату: :types.',
    'error_before'             => 'Поле :attribute должно быть датой до :other.',
    'error_before_or_equal'    => 'Поле :attribute должно быть датой до или равной :other.',
    'error_after'              => 'Поле :attribute должно быть датой после :other.',
    'error_after_or_equal'     => 'Поле :attribute должно быть датой после или равной :other.',

    // Files
    'error_file'         => 'Поле :attribute должно быть файлом.',
    'error_image'        => 'Поле :attribute должно быть изображением.',
    'error_mimes'        => 'Файл :attribute должен быть одного из типов: :types.',
    'error_extensions'   => 'Файл :attribute должен иметь одно из расширений: :types.',
    'error_dimensions'   => 'Файл :attribute имеет недопустимые размеры изображения.',
    'error_min_file'     => 'Файл :attribute должен быть не менее :count килобайт.',
    'error_max_file'     => 'Файл :attribute не должен превышать :count килобайт.',
    'error_size_file'    => 'Файл :attribute должен быть ровно :count килобайт.',
    'error_between_file' => 'Размер файла :attribute должен быть от :min до :max килобайт.',

    // File list
    'error_min_files'     => 'Поле :attribute должно содержать не менее :count файлов.',
    'error_max_files'     => 'Поле :attribute не должно содержать более :count файлов.',
    'error_size_files'    => 'Поле :attribute должно содержать ровно :count файлов.',
    'error_between_files' => 'Поле :attribute должно содержать от :min до :max файлов.',

    // Database
    'error_unique' => 'Значение поля :attribute уже используется.',
    'error_exists' => 'Значение поля :attribute уже существует в базе данных.',

    // Utilities
    'error_required'     => 'Поле :attribute обязательно для заполнения.',
    'error_required_if'  => 'Поле :attribute обязательно, если :other равно :value.',
    'error_filled'       => 'Поле :attribute не должно быть пустым.',
    'error_nullable'     => 'Поле :attribute может быть null.',
    'error_empty'        => 'Поле :attribute должно быть пустым.',
];