class Category < ApplicationRecord

  # アソシエーション
  has_many :items
  belongs_to :shop

  # バリデーション
  validates :name, presence: { message: "・カテゴリー名を入力して下さい。" }, length: { maximum: 10 }

end
