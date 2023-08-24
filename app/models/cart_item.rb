class CartItem < ApplicationRecord

  # アソシエーション
  belongs_to :user
  belongs_to :item

  # バリデーション
  validates :amount, presence: true, numericality: { only_integer: true, greater_than: 0 }


end
