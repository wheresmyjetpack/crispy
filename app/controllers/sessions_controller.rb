class SessionsController < ApplicationController
  def new
  end

  def create
    Sessions::AuthenticateUser.call(email: params[:session][:email], password: params[:session][:password]) do
      on(:ok) { |user| flash[:success] = "Welcome to the app!" }
      on(:danger) do
        flash.now[:danger] = 'Invalid email/password'
        render 'new'
      end
    end
  end

  def destroy
  end
end
