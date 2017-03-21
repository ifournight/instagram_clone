class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: :set_locale

  def index
    @post = current_user.posts.build
    @feeds = current_user.post_feeds.page(params[:page]).per(10)
    respond_to do |format|
      format.html { render :index }
      format.js { render :index }
    end
  end

  def set_locale
    if locale_param
      cookies[:locale] = locale_param
      respond_to do |format|
        format.html { redirect_to request.referer || root_url }
      end
    end
  end

  def locale_param
    return nil if params[:locale].nil? || params[:locale].empty?
    if I18n.available_locales.include? params[:locale].to_sym
      params[:locale].to_sym
    else
      nil
    end
  end
end
