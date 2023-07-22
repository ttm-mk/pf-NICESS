class Item < ApplicationRecord
  
  belongs_to :shop
  
  has_one_attached :item_image
  
end
