<?php

use Phinx\Migration\AbstractMigration;

class CreateBlogPostsTable extends AbstractMigration
{
    public function change(): void
    {
        $t = $this->table('blog_posts', ['id' => true, 'primary_key' => ['id']]);
        $t
            ->addColumn('title', 'string', ['null' => false, 'limit' => 255])
            ->addColumn('alias', 'string', ['null' => false, 'limit' => 100])
            ->addColumn('description', 'text', ['null' => true])
            ->addColumn('img', 'string', ['null' => true, 'limit' => 255])
            ->addColumn('content', 'text', ['null' => true])
            ->addColumn('author_id', 'integer', ['null' => false, 'limit' => 10, 'default' => '0', 'signed' => false])
            ->addColumn('user_id', 'integer', ['null' => false, 'limit' => 10, 'default' => '0', 'signed' => false])
            ->addColumn('views', 'integer', ['null' => false, 'limit' => 10, 'default' => '0', 'signed' => false])
            ->addColumn('category', 'enum', ['null' => true, 'values' => ['articles', 'equipment', 'guides', 'reports', 'tips']])
            ->addColumn('tour_id', 'integer', ['null' => false, 'limit' => 10, 'default' => '0', 'signed' => false])
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
            ->addIndex(['title'], ['type' => 'fulltext'])
            ->addIndex(['alias'], ['type' => 'fulltext'])
            ->addIndex(['author_id'])
            ->addIndex(['user_id'])
            ->addIndex(['views'])
            ->addIndex(['category'])
            ->addIndex(['tour_id'])
            ->create();
    }
}