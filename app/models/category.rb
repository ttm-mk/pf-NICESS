class Category < ApplicationRecord

  # アソシエーション
  has_many :items
  belongs_to :shop

  # バリデーション
  validates :name, presence: true, length: { maximum: 10 }

end
