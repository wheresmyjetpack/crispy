class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = current_user    
  end

  def new
  end

  def create
  end
end
