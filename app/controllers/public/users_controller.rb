class Public::UsersController < ApplicationController
  before_action :authenticate_user!


# relationshipの記述
  def followings
    @user = User.find_by(name_id: params[:id])
    @following_users = user.followings
  end

  def followers
    user = User.find(params[:name_id])
    @users = user.followers
  end


  def show
    @users = User.all
    @user = User.find_by(name_id: params[:id])
    # redirect_to root_path, notice: 'ユーザーはいません' and return if @user.nil?
    @post = Post.new
    @user_posts = @user.posts.all.order(created_at: :desc).page(params[:page])

    # いいね取得
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)

    # フォローユーザー取得
    @following_users = @user.followings
    @shop = @user.shop
  end

  def edit
    if current_user.email == "guest@sample.com"
      redirect_to root_path, notice: "機能のご利用にはユーザー登録が必要です。"
    else
      @user = User.find_by(name_id: params[:id])
    end
  end

  def user_orders
    if current_user.email == "guest@sample.com"
      redirect_to root_path, notice: "機能のご利用にはユーザー登録が必要です。"
    else
      @user = User.find_by(name_id: params[:name_id])
      @shop = @user.shop
      @orders = @user.orders
    end

  end

  def confirm
    if current_user.email == "guest@sample.com"
      redirect_to root_path, notice: "機能のご利用にはユーザー登録が必要です。"
    end
  end

  def resign
    if current_user.email == "guest@sample.com"
      redirect_to root_path, notice: "機能のご利用にはユーザー登録が必要です。"
    else
      user = current_user
      user.update(is_deleted: true)
      reset_session
      redirect_to root_path
    end
  end

  def update
    @user = User.find_by(name_id: params[:id])

    if @user.update!(user_params)
      redirect_to user_path(@user.name_id)
    else
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit(:name, :name_id, :profile, :email, :user_icon)
  end

  def shop_params
    params.require(:user).permit(:shop_name, :shop_introduction)
  end

end
