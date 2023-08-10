class Order < ApplicationRecord

  # アソシエーション
  belongs_to :user
  belongs_to :shop
  has_many :order_details, dependent: :destroy
  has_many :items, through: :order_details


  # バリデーション
  # validates :client_name, presence: { message: "・あなたの名前を入力して下さい。" }
  # validates :client_phone_number, presence: { message: "・あなたの電話番号を入力して下さい。" }, numbericality: { only_integer: true, in: 10..11 }
  # validates :client_email, presence: { message: "あなたのメールアドレスを入力して下さい。" }
  # validates :delivery_post_code, presence: { message: "配送先郵便番号を入力して下さい。" }, numbericality: { only_integer: true, equal_to: 7 }
  # validates :delivery_address, presence: { message: "配送先住所を入力して下さい。" }
  # validates :delivery_name, presence: { message: "配送先の宛名を入力して下さい。" }
  # validates :payment_method, presence: { message: "支払い方法を選択して下さい。" }


  # enum管理
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { waiting_payment: 0, checked: 1, preparation: 2, finished: 3 }

end
