class CommentsController < ApplicationController
  def new
  end

  def create
    user = User.find(params[:user_id])
    post = Post.find(params[:post_id])
    @comment = user.comment_on(post, comment_params[:content])

    @comment.save

    redirect_to request.referer || root_url
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :user_id, :post_id)
  end
end
