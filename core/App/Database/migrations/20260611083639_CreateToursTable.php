<?php

use Phinx\Migration\AbstractMigration;

class CreateToursTable extends AbstractMigration
{
    public function change(): void
    {
        $t = $this->table('tours', ['id' => true, 'primary_key' => ['id']]);
        $t
            ->addColumn('author_id', 'integer', ['null' => false, 'limit' => 10, 'default' => '0', 'signed' => false])
            ->addColumn('context_key', 'string', ['null' => false, 'limit' => 50, 'default' => 'web'])
            ->addColumn('title', 'string', ['null' => false, 'limit' => 255, 'comment' => 'Название тура'])
            ->addColumn('alias', 'string', ['null' => true, 'limit' => 100, 'comment' => 'Псевдоним'])
            ->addColumn('img', 'string', ['null' => true, 'limit' => 255, 'comment' => 'Изображение тура'])
            ->addColumn('country_id', 'integer', ['null' => false, 'limit' => 10, 'default' => '0', 'signed' => false])
            ->addColumn('city_id', 'integer', ['null' => false, 'limit' => 10, 'default' => '0', 'signed' => false])
            ->addColumn('level', 'decimal', ['null' => false, 'precision' => 3, 'scale' => 1, 'comment' => 'Сложность от 1 до 5 с шагом 0.1', 'default' => '1'])
            ->addColumn('type_tour', 'enum', ['null' => true, 'comment' => 'Тип туристической активности', 'values' => ['trekking', 'mountaineering', 'motorcycling', 'yachting', 'rafting']])
            ->addColumn('altitude', 'integer', ['null' => true, 'limit' => 10, 'comment' => 'Высота в метрах', 'signed' => false])
            ->addColumn('distance', 'integer', ['null' => true, 'limit' => 10, 'comment' => 'Расстояние в км', 'signed' => false])
            ->addColumn('content', 'text', ['null' => true, 'comment' => 'Основной контент'])
            ->addColumn('model_type', 'string', ['null' => true, 'limit' => 191])
            ->addColumn('model_id', 'integer', ['null' => true])
            ->addColumn('menuindex', 'integer', ['null' => false, 'default' => 0])
            ->addColumn('published_at', 'datetime', ['null' => true])
            ->addColumn('data', 'json', ['null' => true])
            ->addTimestamps()
            ->addColumn('deleted_at', 'datetime', ['null' => true])
            ->addIndex(['model_type', 'model_id'])
            ->addIndex(['menuindex'])
            ->addIndex(['published_at'])
            ->addIndex(['author_id'])
            ->addIndex(['country_id'])
            ->addIndex(['city_id'])
            ->addIndex(['level'])
            ->addIndex(['type_tour'])
            ->addIndex(['altitude'])
            ->addIndex(['distance'])
            ->create();
    }
}