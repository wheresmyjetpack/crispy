class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @user = current_user
  end

  def show
    @user = current_user    
  end

  def new
    redirect_to(root_url) if current_user
    @user = User.new
  end

  def create
  end
end
