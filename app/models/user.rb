class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:name_id]


  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  belongs_to :shop, dependent: :destroy
  

  # relationshipアソシエーション:TODO
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # ↑フォロー関係

  has_many :followings, through: "relationships", source: :followed
  has_many :followers, through: "reverse_of_relationships", source: :follower
  # ↑一覧用

  has_one_attached :user_icon

  validates :name_id, uniqueness: true

# ゲスト関係：TODO
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
  

# ユーザーアイコン
  def get_user_icon(width, height)
    unless user_icon.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      user_icon.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    user_icon.variant(resize_to_limit: [width, height]).processed
  end

  # TODO
  # フォロー機能
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end


end
