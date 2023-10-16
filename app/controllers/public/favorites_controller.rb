class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!


  def create
    favorite = Favorite.new(user_id: params[:user_id], post_id: params[:post_id])
    if !favorite.save
      redirect_to root_path
    else
      redirect_to user_post_path(Post.find(params[:post_id]).user.name_id, params[:post_id])
    end

  end

  def destroy
    favorite = Favorite.find_by(user_id: params[:user_id], post_id: params[:post_id])
    if favorite.destroy
      redirect_to user_post_path(Post.find(params[:post_id]).user.name_id, params[:post_id])
    else
      redirect_to root_path
    end

  end


end
