class Public::ShopsController < ApplicationController

  def index
  end

  def new
    @user = User.find_by(id: params[:user_id])
    @shop = Shop.new
  end

  def create
    @shop = Shop.new(shop_params)
    # @user = User.find_by(id: params[:user_id])
    params[:user_id] = current_user.id
    if @shop.save!
      redirect_to user_shop_path(@user.name_id)
    else
      user_path(current_user.name_id)
    end
  end

  def update
  end


  private

  def shop_params
    params.require(:shop).permit(:name, :introduction)
  end
end
