class Comment < ApplicationRecord

  # アソシエーション
  belongs_to :user
  belongs_to :post

  # バリデーション
  validates :text, presence: { message: "コメントを入力して下さい。" }, length: { maximum: 200 }


end
