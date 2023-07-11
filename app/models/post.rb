class Post < ApplicationRecord
  has_many :comments, dependent: :destroy

  belongs_to :user
  has_many :favorites, dependent: :destroy

  has_one_attached :image
  
  
  def favorite_by?(user)
    favorites.exists?(user_id: user_id)
  end

end
