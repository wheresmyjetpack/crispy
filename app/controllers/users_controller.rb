class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @user = current_user
  end

  def show
    @user = current_user    
  end

  def new
  end

  def create
  end
end
