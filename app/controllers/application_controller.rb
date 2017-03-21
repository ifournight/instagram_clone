class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :authenticate_user!

  layout :dynamic_layout


  private

  def dynamic_layout
    case controller_name
    when 'registrations'
      'signup'
    when 'sessions'
      'signup'
    when 'passwords'
      'signup'
    else
      'application'
    end
  end

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    sign_in_path
  end

  # Set locale based on locale in params hash
  def set_locale
    debugger
    I18n.locale = cookies[:locale] || params[:locale] || http_accept_language.compatible_language_from(I18n.available_locales) || I18n.default_locale
  end
end
