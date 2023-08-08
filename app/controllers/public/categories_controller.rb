class Public::CategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user.name_id
    @shop = current_user.shop
    @category = Category.new
    @categories = @shop.categories.all
  end

  def edit
    @shop = current_user.shop
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(category_params)
    @category.shop_id = current_user.shop.id
    if @category.save
      redirect_to user_shop_categories_path(current_user.name_id)
    else
      redirect_to user_shop_path(current_user.name_id)
    end
  end

  def update
    category = Category.find(params[:id])
    category.shop.id = current_user.shop.id
    if category.update(category_params)
      redirect_to user_shop_categories_path(current_user.name_id)
    else
      redirect_to edit_user_shop_category_path(current_user.name_id, category)
    end
  end

  def destroy
    category = Category.find(params[:id])
    category.shop.id = current_user.shop.id
    if category.destroy
      redirect_to user_shop_categories_path(current_user.name_id)
    else
      redirect_to user_shop_path(current_user.name_id)
    end
  end


  private

  def category_params
    params.require(:category).permit(:name, :shop_id)
  end

end
