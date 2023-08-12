class Public::HomesController < ApplicationController
    before_action :authenticate_user!, except: [:top, :about]


  def top
    @users = User.all
    @post = Post.new
    @post_data = Post.all.order(created_at: :desc)
    @posts = Kaminari.paginate_array(@post_data).page(params[:page])
    @shops = Shop.all

    if params[:search] || params[:seek].present?
      @post_data = Post.where('text LIKE ?', "%#{params[:search]}%")
      @posts = Kaminari.paginate_array(@post_data).page(params[:page])
      @users = User.where('name LIKE ?', "%#{params[:seek]}%")

    else
      @post_data = Post.all.order(created_at: :desc)
      # @posts = Kaminari.paginate_array(@post_data).page(params[:page])
      @posts = Post.all.order(created_at: :desc).page(params[:page])
    end
  end

  def about
  end

end
