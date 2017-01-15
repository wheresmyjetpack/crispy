class ShoppingItemsController < ApplicationController
  before_filter :authenticate_user!

  def show
    @shopping_list = session[:shopping_list]
  end

  def new
  end

  def create
    session[:shopping_list] = ShoppingItems::PrepareShoppingList.call(params[:shopping_list])
    redirect_to action: :show
  end
end
