class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def authenticate_user!
    redirect_to(login_path, notice: 'You must sign in') unless user_signed_in?
  end
end
