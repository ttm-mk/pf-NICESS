class Order < ApplicationRecord

  # アソシエーション
  belongs_to :user
  belongs_to :shop
  has_many :order_details, dependent: :destroy
  has_many :items, through: :order_details


  # バリデーション
  validates :client_name, presence: true
  validates :client_phone_number, presence: true, numericality: { only_integer: true }
  validates :client_email, presence: true
  validates :delivery_post_code, presence: true, numericality: { only_integer: true }
  validates :delivery_address, presence: true
  validates :delivery_name, presence: true
  validates :payment_method, presence: true

  # enum管理
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { waiting_payment: 0, checked: 1, preparation: 2, finished: 3 }

end
