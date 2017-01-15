class UsersController < ApplicationController
  def show
    redirect_to(login_url) if current_user.nil?
    @user = current_user    
  end

  def new
  end

  def create
  end
end
