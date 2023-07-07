class Public::PostsController < ApplicationController

  # def index
  #   @posts
  # end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if !@post.save
      redirect_to root_path
    else
      redirect_to user_path(current_user)
    end
  end

  private

  def post_params
    params.require(:post).permit(:text, :profile_image)
  end

end
