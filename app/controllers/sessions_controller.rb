class SessionsController < ApplicationController
  def new
  end

  def create
    Sessions::AuthenticateUser.call(email: params[:session][:email], password: params[:session][:password]) do
      on(:ok) do |user| 
        log_in user
        flash[:success] = "Welcome to the app!"

        redirect_to user
      end
      on(:danger) do
        flash.now[:danger] = 'Invalid email/password'
        render 'new'
      end
    end
  end

  def destroy
  end
end
