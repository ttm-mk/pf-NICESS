class Public::CategoriesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @user = current_user.name_id
    @shop = current_user.shop
    @category = Category.new
    @categories = @shop.categories.all
  end
  
  def edit
    @category = Category.find(params[:id])
  end
  
  def create
    @category = Category.new(category_params)
    @category.shop_id = current_user.shop.id
    if @category.save
      redirect_to user_shop_categories_path(current_user.name_id)
    else
      redirect_to edit_user_shop_category_path
    end
  end
  
  def update
  end
  
  def destroy
  end
  
  
  private
  
  def category_params
    params.require(:category).permit(:name, :shop_id)
  end
  
end
