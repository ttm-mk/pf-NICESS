class Shop < ApplicationRecord

  # アソシエーション
  belongs_to :user
  has_many :items, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :categories, dependent: :destroy

  # バリデーション
  validates :name, presence: true, length: { maximum: 20 }
  validates :introduction, length: { maximum: 200 }
  validates :postage, presence: true, numbericality: { only_integer: true }

end
