class HomeController < ApplicationController
  def index
    @post = current_user.posts.build
    @feeds = current_user.post_feeds.page(params[:page]).per(10)
    respond_to do |format|
      format.html { render :index }
      format.js { render :index }
    end
  end
end
