class Shop < ApplicationRecord
  
  belongs_to :user
  has_many :items, dependent: :destroy
  has_many :orders, dependent: :destroy
  
end
