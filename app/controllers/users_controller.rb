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
    Users::Signup.call(params) do
      on(:ok) do
        flash[:success] = 'Thanks for signing up! Please login to continue.'
        redirect_to login_path
      end

      on(:invalid) do |errors|
        flash[:danger] =  errors
        redirect_to :back
      end
    end
  end
end
