class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      
      t.string :client_name, null: false
      t.string :client_phone_number, null: false
      t.string :client_email, null: false
      t.string :delivery_post_code, null: false
      t.string :delivery_address, null: false
      t.string :delivery_name, null: false
      t.integer :postage, null: false
      t.integer :total_payment, null: false
      t.integer :payment_method, null: false
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
