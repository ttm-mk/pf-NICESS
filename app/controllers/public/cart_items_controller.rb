class Public::CartItemsController < ApplicationController

  def index
    @cart_items = current_user.cart_items
    @shop = Shop.find(params[:user_id])
    # TODO
    item_ids = Item.where(shop_id: @shop.id).pluck(:id)
    @cart_items = current_user.cart_items.where(item_id: item_ids)
    # p "pで以下を表示する",@cart_items
    # pp "ppで以下を表示する",@cart_items

    # @cart_items = current_user.cart_items
    # @sub_total = cart_item * params[:cart_item][:amount]
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @item = Item.find_by(id: params[:cart_item][:item_id])
    # @cart_item.user_id = params[:user_id]
    @cart_item.user_id = current_user.id
    if @cart_item.save
      redirect_to user_shop_cart_items_path(params[:user_id])
    else
      user_shop_path(@item.shop.user.name_id)
    end
  end

  def update
  end

  def destroy
    CartItem.find_by(id: params[:id]).destroy
    redirect_to user_shop_cart_items_path(current_user)
  end

  def destroy_all
  end


  private

  def cart_item_params
    params.require(:cart_item).permit(:amount, :item_id)
  end

end
