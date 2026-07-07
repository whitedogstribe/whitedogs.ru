<?php

use Phinx\Migration\AbstractMigration;

class CreateShopCategoriesTable extends AbstractMigration
{
    public function change(): void
    {
        $t = $this->table('shop_categories', ['id' => true, 'primary_key' => ['id']]);
        $t
            ->addColumn('title', 'string', ['null' => false, 'limit' => 255])
            ->addColumn('alias', 'string', ['null' => false, 'limit' => 100])
            ->addColumn('longtitle', 'string', ['null' => true, 'limit' => 255])
            ->addColumn('description', 'text', ['null' => true])
            ->addColumn('content', 'text', ['null' => true])
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
            ->addIndex(['alias'], ['unique' => true])
            ->create();
    }
}