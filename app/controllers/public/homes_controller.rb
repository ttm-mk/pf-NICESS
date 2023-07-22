class Public::HomesController < ApplicationController
  def top
    @users = User.all
    @post = Post.new
    @posts = Post.all
    @shops = Shop.all

    if params[:search] || params[:seek].present?
      @posts = Post.where('text LIKE ?', "%#{params[:search]}%")
      @users = User.where('name LIKE ?', "%#{params[:seek]}%")
    
    elsif params[:category].present?
      @category = Category.find(params[:name])

    else
      @posts = Post.all
    end
  end

  def about
  end

end
