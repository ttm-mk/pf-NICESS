class Post < ApplicationRecord

  # アソシエーション
  has_many :comments, dependent: :destroy
  belongs_to :user
  has_many :favorites, dependent: :destroy

  has_one_attached :image


  # バリデーション
  validates :text, presence: { message: "文章を入力して下さい。(200字以内)" }, length: { maximum: 200 }


  # ページネーション
  paginates_per 5

# TODO
  def favorite_by?(favorited_user)
    return false unless favorited_user
    favorites.exists?(user_id: favorited_user.id)
  end
end
