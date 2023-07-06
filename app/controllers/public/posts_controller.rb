class Public::PostsController < ApplicationController
  
  def index
    @posts
  end
  
  def create
    @post = Post.new(params[:id])
    @post.user_id = current_user.id
    @post.save
    redirect_to root_path(current_user)
  end
  
end
