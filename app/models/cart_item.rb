class CartItem < ApplicationRecord

  # アソシエーション
  belongs_to :user
  belongs_to :item

  # バリデーション
  # validates :amount, presence: true, numbericality: { only_integer: true, greater_than: 0 }

  # def guest_check
  #   if current_user == User.find(2)
  #     redirect_to root_path, notice: "このページを見るにはユーザー登録が必要です。"
  #   end
  # end

end
