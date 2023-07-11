class Public::FavoritesController < ApplicationController
  before_action :authentication_user!
    
  def create
    post = Post.find_by(post_id: post.id)
    favorite = Favorite.new(user_id: current_user_id, post_id: post_id)
    if !favorite.save
      root_path
    else
      redirect_to user_post_path(post)
    end
    
  end
    
  def destroy
    post = Post.find(params[:id])
    favorite = current_user.favorite.find_by(post_id: post.id)
    if !favorite.destroy
      root_path
    else
      redirect_to user_post_path(post)
    end
    
  end


end
