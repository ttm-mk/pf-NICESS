class Comment < ApplicationRecord

  # アソシエーション
  belongs_to :user
  belongs_to :post

  # バリデーション
  validates :text, presence: true, length: { maximum: 200 }


end
