<?php

use Phinx\Migration\AbstractMigration;

class CreateTourDatesTable extends AbstractMigration
{
    public function change(): void
    {
        $t = $this->table('tour_dates', ['id' => true, 'primary_key' => ['id']]);
        $t
            ->addColumn('start_date', 'date', ['null' => false, 'comment' => 'Дата начала'])
            ->addColumn('end_date', 'date', ['null' => false, 'comment' => 'Дата окончания'])
            ->addColumn('price', 'decimal', ['null' => false, 'precision' => 10, 'scale' => 2, 'comment' => 'price', 'default' => '0'])
            ->addColumn('currency', 'string', ['null' => true, 'limit' => 50, 'default' => '$'])
            ->addColumn('price_usd', 'decimal', ['null' => false, 'precision' => 10, 'scale' => 2, 'comment' => 'Цена в долларах', 'default' => '0'])
            ->addColumn('discount', 'integer', ['null' => false, 'limit' => 10, 'comment' => 'Скидка в %', 'default' => '0', 'signed' => false])
            ->addColumn('discount_people', 'integer', ['null' => false, 'limit' => 10, 'comment' => 'Места со скидкой', 'default' => '0', 'signed' => false])
            ->addColumn('people', 'integer', ['null' => false, 'limit' => 10, 'comment' => 'Количество записавшихся', 'default' => '0', 'signed' => false])
            ->addColumn('max_people', 'integer', ['null' => false, 'limit' => 10, 'comment' => 'Максимальное количество участников', 'default' => '0', 'signed' => false])
            ->addColumn('status', 'enum', ['null' => false, 'default' => 'open', 'values' => ['open', 'closed']])
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
            ->addIndex(['start_date'])
            ->create();
    }
}