<?php

use Phinx\Migration\AbstractMigration;

class CreateCitiesTable extends AbstractMigration
{
    public function change(): void
    {
        $t = $this->table('cities', ['id' => true, 'primary_key' => ['id']]);
        $t
            ->addColumn('name', 'string', ['null' => true, 'limit' => 100, 'comment' => 'Название города'])
            ->addColumn('alias', 'string', ['null' => false, 'limit' => 100, 'comment' => 'Псевдоним города'])
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