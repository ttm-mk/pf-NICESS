class CreateShops < ActiveRecord::Migration[6.1]
  def change
    create_table :shops do |t|
      
      t.string :name
      t.text :introduction
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
