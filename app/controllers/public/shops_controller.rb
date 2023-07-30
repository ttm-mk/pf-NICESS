class Public::ShopsController < ApplicationController

  def show
    @user = User.find_by(name_id: params[:user_id])
    @shop = @user.shop
    @items = @shop.items.all
  end

  def new
    @user = User.find_by(id: params[:user_id])
    @shop = Shop.new
  end
  
  def edit
    @shop = current_user.shop
  end

  def create
    @shop = Shop.new(shop_params)
    @user = User.find(params[:user_id])
    @shop.user_id = @user.id
    if @shop.save
      redirect_to user_shop_path(@shop.user.name_id)
    else
      user_path(current_user.name_id)
    end
  end

  def update
    shop = current_user.shop
    shop.user_id = current_user.id
    if shop.update(shop_params)
      redirect_to user_shop_path(shop.user.name_id)
    end
    
  end


  private

  def shop_params
    params.require(:shop).permit(:name, :introduction, :user_id)
  end
end
