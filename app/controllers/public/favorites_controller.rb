class Public::FavoritesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    favorite = Favorite.new(user_id: current_user.id, post_id: @post)
    if !favorite.save
      redirect_to root_path
    else
      redirect_to user_post_path(params[:post_id])
    end

  end

  def destroy
    # @post = Post.find_by(id: params[:id])
    favorite = Favorites.find_by(user_id: current_user.id, post_id: params[:id])
    if favorite.destroy
      redirect_to user_post_path(params[:post_id])
    else
      redirect_to root_path
    end

  end


end
