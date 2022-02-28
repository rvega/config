<?php

// https://cs.symfony.com/doc/rules/index.html

$config = new PhpCsFixer\Config();

return $config->setRules([

    '@PSR12' => true,

    'array_indentation' => true,

    'single_quote' => true,

    'concat_space' => ['spacing'=>'one'],

    'class_attributes_separation' => [
        'elements' => [
            'const'    => 'only_if_meta',
            'method'   => 'one',
            'property' => 'only_if_meta'
        ]
    ],

    'binary_operator_spaces' => [
        'operators' => [
            '='  => 'single_space',
            '=>' => 'align_single_space_minimal'
        ]
    ],

    'phpdoc_add_missing_param_annotation' => [
        'only_untyped' => false
    ]

]);
