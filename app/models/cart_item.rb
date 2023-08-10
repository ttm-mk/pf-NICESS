class CartItem < ApplicationRecord

  # アソシエーション
  belongs_to :user
  belongs_to :item

  # バリデーション
  validates :amount, presence: { message: "・商品数を選択して下さい。" }, numbericality: { only_integer: true, greater_than: 0 }

end
