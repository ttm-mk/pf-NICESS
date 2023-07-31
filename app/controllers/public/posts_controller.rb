class Public::PostsController < ApplicationController

  def index
    @user = User.find_by(name_id: params[:user_id])
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if !@post.save
      redirect_to root_path
    else
      redirect_to user_path(current_user)
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def destroy
    post = Post.find(params[:id])
    redirect_to root_path and return if !post.user_id == current_user.id
    post.destroy
    redirect_to user_posts_path(post.user.name_id)

  end

  private

  def post_params
    params.require(:post).permit(:text, :image)
  end

end
