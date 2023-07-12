class Public::UsersController < ApplicationController

  def show
    @user = User.find_by(name_id: params[:id])
    redirect_to root_path, notice: 'ユーザーいません' and return if @user.nil?
    # @posts = @user.posts.all
    @post = Post.new
    @posts = Post.all
  end

  def edit
  end

  def confirm
  end

  def resign
  end

  def update
  end

end
