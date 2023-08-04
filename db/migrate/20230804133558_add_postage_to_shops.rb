class AddPostageToShops < ActiveRecord::Migration[6.1]
  def change
    add_column :shops, :postage, :integer
  end
end
