class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:name_id]


  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_one_attached :user_icon

  validates :name_id, uniqueness: true

  def self.guest
    find_or_create_by!(email: 'guest@sample.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      # ランダムパスワード作成
      user.name = "ゲスト"
      # ユーザーネームをゲストに固定
      user.name_id = SecureRandom.alphanumeric(8)
      # ネームIDをランダムに作成
    end
  end

  def get_user_icon
    unless user_icon.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      user_icon.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    user_icon.variant(resize_to_limit: [100, 100]).processed
  end
end
