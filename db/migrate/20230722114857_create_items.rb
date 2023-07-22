class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|

      t.string :name, null: false
      t.integer :price, null: false
      t.text :introduction, null: false
      t.integer :stock, null: false
      t.boolean :is_sale, null: false
      t.integer :shop_id, null: false
      t.integer :category_id

      t.timestamps
    end
  end
end
