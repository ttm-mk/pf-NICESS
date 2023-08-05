class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      
      t.string :name, null: false
      t.integer :shop_id, null: false

      t.timestamps
    end
  end
end
