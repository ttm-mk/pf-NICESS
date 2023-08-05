class Public::CartItemsController < ApplicationController
  before_action :authenticate_user!


  def index
    # TODO 確認
    cart_items = current_user.cart_items.joins(:item).select('cart_items.*, items.shop_id')
    @shops = Shop.where(id: cart_items.pluck(:shop_id))
    @cart_items = {}
    @shops.each do |shop|
      cart_items.each do |cart_item|
        if shop.id == cart_item.shop_id
          @cart_items[shop.name] = [] if @cart_items[shop.name].blank?
          @cart_items[shop.name] << cart_item
        end
      end
    end
    # # p "pで以下を表示する",@cart_items
    # pp "ppで以下を表示する",@cart_items

  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @item = Item.find_by(id: params[:cart_item][:item_id])
    @cart_item.user_id = current_user.id

    if current_user.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
      cart_item = current_user.cart_items.find_by(item_id: params[:cart_item][:item_id])
      cart_item.amount += params[:cart_item][:amount].to_i
      cart_item.save
      redirect_to cart_items_path(current_user, {shop_id: @item.shop.id}, {name_id: @item.shop.user.name_id})
    elsif @cart_item.save
      redirect_to cart_items_path(current_user, {shop_id: @item.shop.id}, {name_id: @item.shop.user.name_id})
    else
      user_shop_path(@item.shop.user.name_id)
    end
  end

  def update
    cart_item = CartItem.find(params[:id])
    @item = Item.find_by(id: params[:cart_item][:item_id])
    cart_item.user_id = current_user.id
    if cart_item.update(cart_item_params)
      redirect_to cart_items_path(current_user, {shop_id: @item.shop.id}, {name_id: @item.shop.user.name_id})
    else
      redirect_to root_path
    end

  end

  def destroy
    CartItem.find_by(id: params[:id]).destroy
    redirect_to cart_items_path(current_user)
  end

  def destroy_all
    @cart_items = current_user.cart_items.all
    if @cart_items.destroy_all
      redirect_to cart_items_path(current_user)
    else
      redirect_to root_path
    end
  end


  private

  def cart_item_params
    params.require(:cart_item).permit(:amount, :item_id)
  end

end
