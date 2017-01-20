class ApplicationController < ActionController::Base
  include SessionsHelper
  include NavHelper

  protect_from_forgery with: :exception
  helper_method :user_signed_in?

  def authenticate_user!
    redirect_to_login unless user_signed_in?
  end

  def redirect_to_login
    flash[:warning] = 'Please sign in before continuing'
    redirect_to(login_path)
  end
end
