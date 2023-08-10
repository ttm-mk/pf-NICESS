class Item < ApplicationRecord

  # アソシエーション
  belongs_to :shop
  belongs_to :category
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  has_many :orders, through: :order_details

  has_one_attached :item_image


  # バリデーション
  validates :name, presence: { message: "・商品名を入力して下さい。" }
  # validates :price, presence: { message: "・商品価格を入力して下さい。(※100円以上)" }, numbericality: { only_integer: true, greater_than_or_equal_to: 100 }
  validates :introduction, presence: { message: "・商品紹介文を入力して下さい。" }
  # validates :stock, presence: { message: "・在庫数を入力して下さい(※在庫数がない場合は、0を入力して下さい)" }, numbericality: { only_integer: true, greater_than_or_equal_to: 0 }


  def get_item_image(width, height)
    unless item_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      item_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    item_image.variant(resize_to_limit: [width, height]).processed
  end


end
