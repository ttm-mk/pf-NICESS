class Public::CommentsController < ApplicationController
  before_action :authenticate_user!
  

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to user_post_path(params[:user_id], params[:post_id])
    else
      render 'public/posts/index'
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    redirect_to root_path, notice: 'ユーザーが異なるため、削除出来ません。' and return unless current_user.id == comment.user_id
    comment.destroy
    redirect_to user_post_path(params[:user_id], params[:post_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, post_id: params[:post_id])
  end
end
