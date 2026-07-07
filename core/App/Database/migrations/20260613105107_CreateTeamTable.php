<?php

use Phinx\Migration\AbstractMigration;

class CreateTeamTable extends AbstractMigration
{
    public function change(): void
    {
        $t = $this->table('team', ['id' => true, 'primary_key' => ['id']]);
        $t
            ->addColumn('name', 'string', ['null' => false, 'limit' => 255, 'comment' => 'Имя'])
            ->addColumn('position', 'string', ['null' => true, 'limit' => 255, 'comment' => 'Должность'])
            ->addColumn('alias', 'string', ['null' => false, 'limit' => 255, 'comment' => 'Псевдоним'])
            ->addColumn('avatar', 'string', ['null' => true, 'limit' => 255, 'comment' => 'Путь к аватару'])
            ->addColumn('group', 'enum', ['null' => false, 'default' => 'instructor', 'values' => ['leader', 'instructor']])
            ->addColumn('seo_title', 'string', ['null' => true, 'limit' => 255, 'comment' => 'EO заголовок'])
            ->addColumn('seo_description', 'text', ['null' => true, 'comment' => 'SEO описание'])
            ->addColumn('description', 'text', ['null' => true, 'comment' => 'Краткое описание'])
            ->addColumn('content', 'text', ['null' => true, 'comment' => 'Полный контент'])
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
            ->addIndex(['group'])
            ->create();
    }
}