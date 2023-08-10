class Shop < ApplicationRecord

  # アソシエーション
  belongs_to :user
  has_many :items, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :categories, dependent: :destroy

  # バリデーション
  validates :name, presence: { message: "・ショップ名を入力して下さい。" }, length: { maximum: 20 }
  validates :introduction, length: { maximum: 200 }
  # validates :postage, presence: { message: "店舗送料を入力して下さい。" }, numbericality: { only_integer: true }

end
