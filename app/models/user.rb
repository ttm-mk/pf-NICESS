class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable



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

end
