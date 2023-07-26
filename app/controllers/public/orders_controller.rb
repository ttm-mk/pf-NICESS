class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @shop = @order.shop
  end

  def index
  end

  def show
  end

  def edit
  end

  def confirm
    @order = Order.new(order_params)
    @cart_items = current_user.cart_items.all
    @total_price = @cart_items.inject(0) { |sum, cart_item| sum + cart_item.item.price }
    @postage = 360
    @total_payment = @postage + @total_price

  end

  def thanks
    @order = Order.find(params[:id])
  end

  def user_orders
    @user_orders = current_user.orders
  end

  def create
    @order = Order.new(order_params)
    @order.user_id = current_user.id
    cart_items = current_user.cart_items.all

    if @order.save
      cart_items.each do |cart_item|
        order_detail = OrderDetail.new(order_detail_params)
        order_detail.item_id = cart_item.item_id
        order_detail.order_id = @order.id
        order_detail.order_price = cart_item.item.price
        order_detail.amount = cart_item.amount
        order_detail.save
      end
      redirect_to orders_thanks_user_shop_path(current_user)
      cart_items.destroy_all
    else
      @order = Order.new(order_params)
      render :new
    end
  end

  def update
  end




  private


  def order_params
    params.require(:order).permit(:client_name, :client_phone_number, :client_email, :delivery_post_code, :delivery_address,
                                  :delivery_name, :postage, :total_payment, :payment_method, :status, :user_id, :shop_id)
  end

  def order_detail_params
    params.require(:order_detail).permit(:amount, :order_price, :item_id, :shop_id)
  end


end
