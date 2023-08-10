class Public::ItemsController < ApplicationController
  before_action :authenticate_user!


  def new
    @item = Item.new
    @user = User.find_by(id: params[:user_id])
    @shop = current_user.shop
    @categories = @shop.categories.all
  end

  def index
    @user = User.find_by(id: params[:user_id])
    @shop = current_user.shop
    @items = @shop.items.all
    @categories = @shop.categories.all
  end

  def show
    @item = Item.find(params[:id])
    @shop = @item.shop
    @user = @shop.user
    @cart_item = CartItem.new
    @categories = @shop.categories.all
  end

  def edit
    @user = User.find_by(id: params[:user_id])
    @shop = @user.shop
    @item = Item.find(params[:id])
    @categories = @shop.categories.all
  end

  def create
    @item = Item.new(shop_item_params)
    @item.shop_id = current_user.shop.id
    if @item.save
      redirect_to user_shop_item_path(@item.shop.user.name_id, @item.id)
    else
      @item = Item.new
      @user = User.find_by(id: params[:user_id])
      @shop = current_user.shop
      @categories = @shop.categories.all
      render :new
    end
  end

  def update
    item = Item.find(params[:id])
    item.shop_id = current_user.shop.id
    if item.update(shop_item_params)
      redirect_to user_shop_item_path(item.shop.user_id)
    else
      user_shop_path(current_user.name_id)
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.shop_id = current_user.shop.id
    redirect_to user_shop_path(current_user.name_id) and return if !item.shop_id == current_user.shop.id
    item.destroy
    redirect_to user_shop_items_path(current_user.shop.id)
  end


  private

  def shop_item_params
    params.require(:item).permit(:item_image, :name, :price, :introduction, :stock, :is_sale, :shop_id, :category_id)
  end

end
