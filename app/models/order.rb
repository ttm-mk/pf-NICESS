class Order < ApplicationRecord

  belongs_to :user
  belongs_to :shop  
  has_many :order_details, dependent: :destroy
  
  # enum管理
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { waiting_payment: 0, checked: 1, preparation: 2, finished: 3 }

end
