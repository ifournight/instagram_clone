class PostsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.build(post_params)
    @post.save
    redirect_to request.referer || root_url
  end

  def destory
  end

  private

  def post_params
    params.require(:post).permit(:content, :user_id, :picture)
  end
end
