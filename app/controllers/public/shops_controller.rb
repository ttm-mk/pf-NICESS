class Public::ShopsController < ApplicationController
  
  def index
  end
  
  def create
    @shop = Shop.new(shop_params)
    @user = User.find_by(name_id: params[:id])
    @shop.user_id == @user.id
    if @shop.save
      redirect_to user_shop_path(@user)
    else
      user_path(@user)
    end
  end
  
  def update
  end
end
