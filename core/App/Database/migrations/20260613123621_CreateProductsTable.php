<?php

use Phinx\Migration\AbstractMigration;

class CreateProductsTable extends AbstractMigration
{
    public function change(): void
    {
        $t = $this->table('products', ['id' => true, 'primary_key' => ['id']]);
        $t
            ->addColumn('title', 'string', ['null' => false, 'limit' => 255])
            ->addColumn('alias', 'string', ['null' => false, 'limit' => 100])
            ->addColumn('article', 'string', ['null' => true, 'limit' => 100])
            ->addColumn('description', 'text', ['null' => true])
            ->addColumn('content', 'text', ['null' => true])
            ->addColumn('price', 'decimal', ['null' => false, 'precision' => 10, 'scale' => 2, 'comment' => 'Цена', 'default' => '0'])
            ->addColumn('old_price', 'decimal', ['null' => false, 'precision' => 10, 'scale' => 2, 'comment' => 'Цена', 'default' => '0'])
            ->addColumn('deposit', 'decimal', ['null' => false, 'precision' => 10, 'scale' => 2, 'comment' => 'Цена', 'default' => '0'])
            ->addColumn('weight', 'decimal', ['null' => true, 'precision' => 10, 'scale' => 3, 'comment' => 'Вес (кг)'])
            ->addColumn('size', 'json', ['null' => true])
            ->addColumn('rental_prices', 'json', ['null' => true])
            ->addColumn('tags', 'json', ['null' => true])
            ->addColumn('images', 'json', ['null' => true])
            ->addColumn('quantity', 'integer', ['null' => false, 'limit' => 10, 'comment' => 'Количество на складе', 'default' => '0', 'signed' => false])
            ->addColumn('rent', 'boolean', ['null' => false, 'comment' => 'Аренда', 'default' => '0'])
            ->addColumn('popular', 'boolean', ['null' => false, 'comment' => 'Популярный товар', 'default' => '0'])
            ->addColumn('is_new', 'boolean', ['null' => false, 'comment' => 'Новинка', 'default' => '0'])
            ->addColumn('on_sale', 'boolean', ['null' => false, 'comment' => 'Распродажа/Акция', 'default' => '0'])
            ->addColumn('in_stock', 'boolean', ['null' => false, 'comment' => 'В наличии', 'default' => '0'])
            ->addColumn('featured', 'boolean', ['null' => false, 'comment' => 'Рекомендуем', 'default' => '0'])
            ->addColumn('category_id', 'integer', ['null' => true, 'limit' => 10, 'comment' => 'ID категории', 'signed' => false])
            ->addColumn('brand', 'string', ['null' => true, 'limit' => 100, 'comment' => 'Бренд/Производитель'])
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
            ->addIndex(['quantity'])
            ->addIndex(['rent'])
            ->addIndex(['popular'])
            ->addIndex(['is_new'])
            ->addIndex(['on_sale'])
            ->addIndex(['in_stock'])
            ->addIndex(['featured'])
            ->addIndex(['category_id'])
            ->create();
    }
}