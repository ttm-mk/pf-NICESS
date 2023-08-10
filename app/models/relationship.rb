class Relationship < ApplicationRecord
  
  # アソシエーション
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  # class_name: "User"でUserモデルから参照しますよとしてる
  
end
