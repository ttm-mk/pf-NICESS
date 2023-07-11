class Public::HomesController < ApplicationController
  def top
    @post = Post.new
    @posts = Post.all
    
    if params[:search].present?
      @posts = Post.where('text LIKE ?', "%#{params[:search]}%")
    
    elsif params[:category].present?
      @category = Category.find(params[:name])

    else
      @posts = Post.all
    end
  end

  def about
  end

end
