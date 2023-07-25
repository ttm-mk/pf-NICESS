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
  end
  
  def thanks
  end
  
  def user_orders
    @user_orders = current_user.orders
  end
  
  def create
    @order = Order.new(order_params)
  end
  
  def update
  end
  
  
  
  
  private
  
  
  def order_params
    params.require(:order).permit(:client_name, :client_phone_number, :client_email, :delivery_post_code, :delivery_address, 
                                  :delivery_name, :postage, :total_payment, :payment_method, :status, :user_id, :shop_id)
  end
  
  
  
  
end
