<?php

use Phinx\Migration\AbstractMigration;

class CreateCountriesTable extends AbstractMigration
{
    public function change(): void
    {
        $t = $this->table('countries', ['id' => true, 'primary_key' => ['id']]);
        $t
            ->addColumn('name', 'string', ['null' => false, 'limit' => 100, 'comment' => 'Название страны'])
            ->addColumn('alias', 'string', ['null' => false, 'limit' => 100, 'comment' => 'Псевдоним страны'])
            ->addColumn('iso', 'string', ['null' => false, 'limit' => 2, 'comment' => 'ISO код страны (2 символа)'])
            ->addColumn('model_type', 'string', ['null' => true, 'limit' => 191])
            ->addColumn('model_id', 'integer', ['null' => true])
            ->addColumn('context_key', 'string', ['null' => false, 'default' => 'web', 'limit' => 50])
            ->addColumn('menuindex', 'integer', ['null' => false, 'default' => 0])
            ->addColumn('published_at', 'datetime', ['null' => true])
            ->addColumn('data', 'json', ['null' => true])
            ->addTimestamps()
            ->addColumn('deleted_at', 'datetime', ['null' => true])
            ->addIndex(['model_type', 'model_id'])
            ->addIndex(['context_key'])
            ->addIndex(['menuindex'])
            ->addIndex(['published_at'])
            ->create();
    }
}