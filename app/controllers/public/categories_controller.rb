class Public::CategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.email == "guest@sample.com"
      redirect_to root_path, notice: "機能のご利用にはユーザー登録が必要です。"
    else
      @user = User.find_by(name_id: params[:user_id])
      @shop = @user.shop
      @category = Category.new
      @categories = @shop.categories.all
    end
  end

  def edit
    if current_user.email == "guest@sample.com"
      redirect_to root_path, notice: "機能のご利用にはユーザー登録が必要です。"
    else
      @user = User.find_by(name_id: params[:user_id])
      @shop = @user.shop
      @category = Category.find(params[:id])
      @categories = @shop.categories.all
    end
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
