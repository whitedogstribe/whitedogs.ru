<?php

use Phinx\Migration\AbstractMigration;

class AddColumnToToursTable extends AbstractMigration
{
    public function change(): void
    {
        $t = $this->table('tours');
        $t
            ->addColumn('countries', 'json', ['null' => true])
            ->update();
    }
}