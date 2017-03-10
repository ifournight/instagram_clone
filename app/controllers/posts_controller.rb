class PostsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.build(post_params)
    if @post.save
      redirect_to request.referer || root_url
    else
      redirect_to request.referer || root_url
    end
  end

  def update
  end

  def destory
  end

  private

  def post_params
    params.require(:post).permit(:content, :user_id)
  end
end
