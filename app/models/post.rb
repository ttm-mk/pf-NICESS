class Post < ApplicationRecord
  has_many :comments, dependent: :destroy

  belongs_to :user
  has_many :favorites, dependent: :destroy

  has_one_attached :image
  
  paginates_per 5

# TODO
  def favorite_by?(favorited_user)
    return false unless favorited_user
    favorites.exists?(user_id: favorited_user.id)
  end
end
