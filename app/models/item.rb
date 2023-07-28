class Item < ApplicationRecord
  
  belongs_to :shop
  has_many :cart_items, dependent: :destroy
  # has_many :orders, through: :order_details
  
  has_one_attached :item_image
  
end