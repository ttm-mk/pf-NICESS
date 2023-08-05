class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!
  

  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
    # 同じ画面に遷移すると
  end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end


end
