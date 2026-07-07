<?php

return [
    'error_failed'        => 'Validation failed.',
    'error_missing'       => 'The :attribute field is missing.',
    'error_csrf'          => 'CSRF token mismatch.',
    'error_recaptcha'     => 'reCAPTCHA verification failed. Please try again.',

    // Boolean
    'error_accepted'      => 'The :attribute must be accepted.',
    'error_accepted_if'   => 'The :attribute must be accepted when :other is :value.',
    'error_boolean'       => 'The :attribute must be a boolean.',
    'error_declined'      => 'The :attribute must be declined.',
    'error_declined_if'   => 'The :attribute must be declined when :other is :value.',

    // String
    'error_alpha'          => 'The :attribute field may only contain letters.',
    'error_alpha_num'      => 'The :attribute field may only contain letters and numbers.',
    'error_alpha_dash'     => 'The :attribute field may only contain letters, numbers, dashes, and underscores.',
    'error_regex'          => 'The :attribute format is invalid.',
    'error_string'         => 'The :attribute field must be a non-empty string.',
    'error_email'          => 'The :attribute field must be a valid email address.',
    'error_confirmed'      => 'The :attribute confirmation does not match the :other.',
    'error_different'      => 'The :attribute must be different from :other.',
    'error_same'           => 'The :attribute must match :other.',
    'error_in'             => 'The :attribute must be one of the following: :types.',
    'error_not_in'         => 'The :attribute must not be one of the following: :types.',
    'error_json'           => 'The :attribute must be a valid JSON string.',
    'error_lowercase'      => 'The :attribute must be lowercase.',
    'error_uppercase'      => 'The :attribute must be uppercase.',
    'error_min_length'     => 'The :attribute must be at least :count characters.',
    'error_max_length'     => 'The :attribute must not exceed :count characters.',
    'error_url'            => 'The :attribute must be a valid URL.',
    'error_uuid'           => 'The :attribute must be a valid UUID.',
    'error_min_string'     => 'The :attribute must be at least :count characters.',
    'error_max_string'     => 'The :attribute must not exceed :count characters.',
    'error_size_string'    => 'The :attribute must be exactly :count characters.',
    'error_between_string' => 'The :attribute must be between :min and :max characters.',

    // Numbers
    'error_numeric'         => 'The :attribute must be a number.',
    'error_integer'         => 'The :attribute must be an integer.',
    'error_decimal'         => 'The :attribute must have between :min and :max decimal places.',
    'error_gt'              => 'The :attribute must be greater than :other.',
    'error_gte'             => 'The :attribute must be greater than or equal to :other.',
    'error_lt'              => 'The :attribute must be less than :other.',
    'error_lte'             => 'The :attribute must be less than or equal to :other.',
    'error_min_digits'      => 'The :attribute must have at least :count digits.',
    'error_max_digits'      => 'The :attribute must have at most :count digits.',
    'error_min_numeric'     => 'The :attribute must be at least :count.',
    'error_max_numeric'     => 'The :attribute must not be greater than :count.',
    'error_size_numeric'    => 'The :attribute must be :count.',
    'error_between_numeric' => 'The :attribute must be between :min and :max.',

    // Arrays
    'error_array'         => 'The :attribute must be an array.',
    'error_contains'      => 'The :attribute must contain at least one of the following: :types.',
    'error_distinct'      => 'The :attribute field has duplicate values.',
    'error_in_array'      => 'The :attribute must exist in :other.',
    'error_min_array'     => 'The :attribute must have at least :count items.',
    'error_max_array'     => 'The :attribute must not have more than :count items.',
    'error_size_array'    => 'The :attribute must contain exactly :count items.',
    'error_between_array' => 'The :attribute must have between :min and :max items.',

    // Dates
    'error_date'               => 'The :attribute is not a valid date.',
    'error_date_equals'        => 'The :attribute must be a date equal to :other.',
    'error_date_format'        => 'The :attribute does not match the format: :types.',
    'error_before'             => 'The :attribute must be a date before :other.',
    'error_before_or_equal'    => 'The :attribute must be a date before or equal to :other.',
    'error_after'              => 'The :attribute must be a date after :other.',
    'error_after_or_equal'     => 'The :attribute must be a date after or equal to :other.',

    // Files
    'error_file'         => 'The :attribute must be a file.',
    'error_image'        => 'The :attribute must be an image.',
    'error_mimes'        => 'The :attribute must be a file of type: :types.',
    'error_extensions'   => 'The :attribute must have one of the following extensions: :types.',
    'error_dimensions'   => 'The :attribute has invalid image dimensions.',
    'error_min_file'     => 'The :attribute must be at least :count kilobytes.',
    'error_max_file'     => 'The :attribute must not be greater than :count kilobytes.',
    'error_size_file'    => 'The :attribute must be :count kilobytes.',
    'error_between_file' => 'The :attribute must be between :min and :max kilobytes.',

    // File list
    'error_min_files'     => 'The :attribute must contain at least :count files.',
    'error_max_files'     => 'The :attribute must not contain more than :count files.',
    'error_size_files'    => 'The :attribute must contain exactly :count files.',
    'error_between_files' => 'The :attribute must contain between :min and :max files.',

    // Database
    'error_unique' => 'The :attribute is already taken.',
    'error_exists' => 'The :attribute already exists in the Database.',

    // utilities
    'error_required'     => 'The :attribute field is required.',
    'error_required_if'  => 'The :attribute field is required when :other is :value.',
    'error_filled'       => 'The :attribute field must not be empty.',
    'error_nullable'     => 'The :attribute may be null.',
    'error_empty'        => 'The :attribute field must be empty.',
];