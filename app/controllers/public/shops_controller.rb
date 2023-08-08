class Public::ShopsController < ApplicationController
  before_action :authenticate_user!


  def show
    @user = User.find_by(name_id: params[:user_id])
    @shop = @user.shop
    @items = @shop.items.all
    @categories = @shop.categories.all
    if params[:category_id].present?
      @category_name = @shop.categories.find_by(id: params[:category_id]).name
      @category_items = @items.where(category_id: params[:category_id])
    end
  end

  def new
    @user = User.find_by(id: params[:user_id])
    @shop = Shop.new
  end

  def edit
    @user = User.find_by(id: params[:user_id])
    @shop = @user.shop
    @categories = @shop.categories.all
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
    params.require(:shop).permit(:name, :introduction, :user_id, :postage)
  end
end
