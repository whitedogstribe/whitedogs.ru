<?php

use Phinx\Migration\AbstractMigration;

class CreateTourTypeTable extends AbstractMigration
{
    public function change(): void
    {
        $t = $this->table('tour_type', ['id' => true, 'primary_key' => ['id']]);
        $t
            ->addColumn('name', 'string', ['null' => false, 'limit' => 100])
            ->addColumn('alias', 'string', ['null' => false, 'limit' => 100])
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