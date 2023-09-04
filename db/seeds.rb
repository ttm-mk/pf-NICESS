# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 管理者
Admin.create!(
  email: ENV['ADMIN_EMAIL'],
  password: ENV['ADMIN_PASSWORD']
)

puts "情報登録を実行します"
# ユーザー
official = User.find_or_create_by!(email: "official_nicess@sample.sam") do |user|
  user.name = "NICESS公式"
  user.password = "nicess7143"
  user.name_id = "nicess_official7474"
  user.profile = "NICESS公式アカウントです。お問い合わせはこちらまで→official_nicess★sample.sam"
  user.is_deleted = false
  user.user_icon = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_icon1.png"), filename:"sample_icon1.png")
end

emuru = User.find_or_create_by!(email: "tkatm098@sample.sam") do |user|
  user.name = "えむる"
  user.password = "ganges2929"
  user.name_id = "emuru2929"
  user.profile = "創作活動しています！漫画一巻公開中！詳しくはショップまで！"
  user.is_deleted = false
  user.user_icon = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_icon2.png"), filename:"sample_icon2.png")
end

nanashi = User.find_or_create_by!(email: "nanashi774@sample.sam") do |user|
  user.name = "ななしのごんべえ"
  user.password = "774774"
  user.name_id = "nanashi_no_gonbe"
  user.profile = "ななしのごんべえ↑20/一次創作活動中/ショップ展開中/次回イベント未定"
  user.is_deleted = false
end

cat = User.find_or_create_by!(email: "cat299@sample.sam") do |user|
  user.name = "猫大好きさん"
  user.password = "299cat299"
  user.name_id = "cat_lover299"
  user.profile = "ねこずきあつまれ"
  user.is_deleted = false
end


# 投稿
Post.find_or_create_by!(text: "こちらのアカウントは、NICESS公式アカウントです。お問い合わせはイントロダクションに記載されているアドレスまでお願い致します。NICESSを盛り上げましょう！") do |post|
  post.user_id = official.id
end

Post.find_or_create_by!(text: "キャラクター紹介【セナ】NICESS公式キャラクター。明るくてムードメーカーな存在。") do |post|
  post.user_id = official.id
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_image1.png"), filename:"sample_image1.png")
end

Post.find_or_create_by!(text: "キャラクター紹介【スイ】NICESS公式キャラクター。双子の姉「セナ」を支える真面目な性格の男の子。") do |post|
  post.user_id = official.id
  post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_image2.png"), filename:"sample_image2.png")
end

Post.find_or_create_by!(text: "ここから活動開始します！まずはショップにきてください！") do |post|
  post.user_id = emuru.id
end

Post.find_or_create_by!(text: "ねこだいすき。画像投稿したいけど、ねこを飼ってないから出来ない。猫カフェさがそ") do |post|
  post.user_id = cat.id
end

Post.find_or_create_by!(text: "なかなか新刊がだせないな。次のイベントはいつになるかな。情報もとむ") do |post|
  post.user_id = nanashi.id
end

# ショップ
Shop.find_or_create_by!(name: "NICESS公式ショップ") do |shop|
  shop.introduction = "NICESS公式ショップです。公式キャラクターやNICESS関連のグッズを販売します。"
  shop.user_id = official.id
  shop.postage = 360
end

Shop.find_or_create_by!(name: "えむるの館") do |shop|
  shop.introduction = "漫画発売中！"
  shop.user_id = emuru.id
  shop.postage = 180
end

Shop.find_or_create_by!(name: "ななしショップ") do |shop|
  shop.introduction = "活動中。過去既刊通販中。"
  shop.user_id = nanashi.id
  shop.postage = 500
end

# # カテゴリー
# Category.find_or_create_by!(name: "グッズ") do |category|
#   category.shop_id = official.shop.id
# end

# Category.find_or_create_by!(name: "漫画") do |category|
#   category.shop_id = emuru.shop.id
# end

# Category.find_or_create_by!(name: "本") do |category|
#   category.shop_id = nanashi.shop.id
# end

# 商品
Item.find_or_create_by!(name: "セナアクリルスタンド") do |item|
  item.price = 500
  item.introduction = "NICESS公式キャラクター「セナ」のアクリルスタンドです。高さ10㎝/土台有り"
  item.stock = 5
  item.is_sale = true
  item.shop_id = official.shop.id
  # item.category_id = Category.find(1).id
  item.item_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_item1.png"), filename:"sample_item1.png")
end

Item.find_or_create_by!(name: "スイアクリルスタンド") do |item|
  item.price = 500
  item.introduction = "NICESS公式キャラクター「スイ」のアクリルスタンドです。高さ10㎝/土台有り"
  item.stock = 5
  item.is_sale = true
  item.shop_id = official.shop.id
  # item.category_id = Category.find(1).id
  item.item_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_item2.png"), filename:"sample_item2.png")
end

Item.find_or_create_by!(name: "最果てのカラム") do |item|
  item.price = 600
  item.introduction = "最果てのカラム１巻～水に囲まれたその島、孤島と思われたその場所は実は湖の真ん中にあり、外には陸が広がっていた……。大陸：カラムの最果てを巡る旅第1巻発売中！"
  item.stock = 10
  item.is_sale = true
  item.shop_id = emuru.shop.id
  # item.category_id = Category.find(2).id
  item.item_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_item3.jpg"), filename:"sample_item3.jpg")
end

Item.find_or_create_by!(name: "既刊「光と影」") do |item|
  item.price = 1000
  item.introduction = "「光と影」をモチーフにしたイラスト本です。全20P/A4/カラー/書きおろしあり"
  item.stock = 10
  item.is_sale = true
  item.shop_id = nanashi.shop.id
  # item.category_id = Category.find(3).id
  item.item_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_item3.jpg"), filename:"sample_item3.jpg")
end

Item.find_or_create_by!(name: "新刊「いざない」") do |item|
  item.price = 400
  item.introduction = "道しるべをモチーフにした作品を集めました。全30P/A4/モノクロ"
  item.stock = 15
  item.is_sale = true
  item.shop_id = nanashi.shop.id
  # item.category_id = Category.find(3).id
  item.item_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample_item3.jpg"), filename:"sample_item3.jpg")
end

puts "情報登録が完了しました"
