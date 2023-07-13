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
  end

  def resign
  end

  def update
    user = User.find_by(name_id: params[:id])
    user.id = current_user.id
    if !user.update(user_params)
      redirect_to root_path
    else
      redirect_to user_path(current_user)
    end
  end

  def user_params
    params.require(:user).permit(:name_id, :email)
  end

end
