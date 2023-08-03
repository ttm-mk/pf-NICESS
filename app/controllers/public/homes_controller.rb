class Public::HomesController < ApplicationController
  def top
    @users = User.all
    @post = Post.new
    @posts = Post.all
    @post_data = Post.all.order(created_at: :desc)
    @posts = Kaminari.paginate_array(@post_data).page(params[:page]).per(3)
    @shops = Shop.all

    if params[:search] || params[:seek].present?
      @post_data = Post.where('text LIKE ?', "%#{params[:search]}%")
      @posts = Kaminari.paginate_array(@post_data).page(params[:page]).per(3)
      # @posts = Post.where('text LIKE ?', "%#{params[:search]}%")
      @users = User.where('name LIKE ?', "%#{params[:seek]}%")

    elsif params[:category].present?
      @category = Category.find(params[:name])

    else
      @posts = Post.all.order(created_at: :desc).page(params[:page]).per(3)
    end
  end

  def about
  end

end
