class Public::UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.all
    @post = Post.new
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
