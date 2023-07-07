class Public::PostsController < ApplicationController
  
  def index
    @posts
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if !@post.save
      redirect_to user_path(current_user)
    else
      redirect_to root_path
    end
  end
  
  private
  
  def post_params
    params.require(:post).permit(:text)
  end
  
end
