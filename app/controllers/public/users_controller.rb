class Public::UsersController < ApplicationController

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
    @user = User.find_by(name_id: params[:id])
    redirect_to root_path, notice: 'ユーザーはいません' and return if @user.nil?
    @following_users = @user.followings
    # @posts = @user.posts.all
    @post = Post.new
    @posts = Post.all
  end

  def edit
    @user = User.find_by(name_id: params[:id])
  end

  def confirm
    # @user = User.find(params[:id])
  end

  def resign
    user = current_user
    user.update(is_deleted: true)
    reset_session
    redirect_to root_path
    
  end

  def update
    @user = User.find_by(name_id: params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.name_id)
    else
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit(:name, :name_id, :profile, :email)
  end

end
