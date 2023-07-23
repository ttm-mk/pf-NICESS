class Public::ItemsController < ApplicationController
  
  def new
    @item = Item.new
    @shop = current_user.shop
  end
  
  def index
    @shop = Shop.find(params[:user_id])
    @items = @shop.items.all
  end
  
  def show
    @shop = Shop.find(params[:id])
    @item = Item.find(params[:id])
  end
  
  def edit
  end
  
  def create
    @item = Item.new(shop_item_params)
    @item.shop_id = current_user.shop.id
    if @item.save
      redirect_to user_shop_item_path(params[:user_id], @item.id)
    else
      redirect_to user_shop_items_path(current_user.shop.id)
    end
  end
  
  def update
  end
  
  def destroy
  end
  
  
  private
  
  def shop_item_params
    params.require(:item).permit(:name, :price, :introduction, :stock, :is_sale, :shop_id)
  end

end
