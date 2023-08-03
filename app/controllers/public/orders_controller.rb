class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @shop = @order.shop
  end

  def index
    @shop = current_user.shop
    @orders = @shop.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @shop = current_user.shop
  end

  def confirm
    @order = Order.new(order_params)
    # cart_items = current_user.cart_items.joins(:item).select('cart_items.*, items.shop_id')
    @cart_items = current_user.cart_items
    # @cart_items = cart_items.where(item_id: cart_items.pluck(:shop_id).group(:item.id))

    @total_price = 0

    @cart_items.each do |cart_item|
      @total_price += (cart_item.item.price * cart_item.amount)
    end

    @postage = 360
    @total_payment = @postage + @total_price

  end

  def thanks
    @order = Order.find(params[:order_id])
    @order_details = @order.order_details
  end

  def user_orders
    @orders = current_user.orders
    @shop = current_user.shop
    @postage = 360
  end

  def create
    @order = Order.new(order_params)
    @order.user_id = current_user.id
    @order.shop.id = params[:order][:shop_id]

    if @order.save
      items = current_user.cart_items.joins(:item).select('cart_items.*, items.shop_id')
      cart_items = items.where(item_id: items.pluck(:shop_id))
      cart_items.each do |cart_item|
        order_detail = OrderDetail.new
        order_detail.item_id = cart_item.item_id
        order_detail.order_id = @order.id
        order_detail.order_price = cart_item.item.price
        order_detail.amount = cart_item.amount
        order_detail.save(order_detail_params)
        # if order_detail.save
        #   order_detail.item.stock - order_detail.amount
        #   item.update
        # end
      end
      redirect_to orders_thanks_user_shop_path(current_user, {order_id: @order.id})
      cart_items.destroy_all
    else
      @order = Order.new(order_params)
      render :new
    end
  end

  def update
    order = Order.find(params[:id])
    order.user_id = current_user.id
    order.shop_id = current_user.shop.id
    if order.update(order_params)
      redirect_to user_shop_order_path(order)
    else
      redirect_to user_shop_orders_path(current_user.name_id, current_user.shop)
    end
  end




  private


  def order_params
    params.require(:order).permit(:client_name, :client_phone_number, :client_email, :delivery_post_code, :delivery_address,
                                  :delivery_name, :postage, :total_payment, :payment_method, :status, :user_id, :shop_id)
  end

  def order_detail_params
    params.repuire(:order_detail).permit(:amount, :order_price, :order_id, :item_id)
  end

end
