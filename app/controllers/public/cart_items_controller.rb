class Public::CartItemsController < ApplicationController

  def index
    @cart_items = current_user.cart_items
    item = Item.where(id: @cart_items.ids)
    @shop = item.pluck(:shop_id)
    # TODO
    # item_ids = Item.where(shop_id: @shop.id).pluck(:id)
    # @cart_items = current_user.cart_items.where(item_id: item_ids)
    # p "pで以下を表示する",@cart_items
    # pp "ppで以下を表示する",@cart_items

    # @sub_total = cart_item * params[:cart_item][:amount]
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @item = Item.find_by(id: params[:cart_item][:item_id])
    # @cart_item.user_id = params[:user_id]
    @cart_item.user_id = current_user.id
    if current_user.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
      cart_item = current_user.cart_items.find_by(item_id: params[:cart_item][:item_id])
      cart_item.amount += params[:cart_item][:amount].to_i
      cart_item.save
      redirect_to cart_items_path(current_user)
    elsif @cart_item.save
      redirect_to cart_items_path(current_user)
    else
      user_shop_path(@item.shop.user.name_id)
    end
  end

  def update
    cart_item = CartItem.find(params[:id])
    cart_item.user_id = current_user.id
    if cart_item.update(cart_item_params)
      redirect_to cart_items_path(current_user)
    else
      redirect_to root_path
    end
    
  end

  def destroy
    CartItem.find_by(id: params[:id]).destroy
    redirect_to cart_items_path(current_user)
  end

  def destroy_all
  end


  private

  def cart_item_params
    params.require(:cart_item).permit(:amount, :item_id)
  end

end
