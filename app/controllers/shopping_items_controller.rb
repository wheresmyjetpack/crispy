class ShoppingItemsController < ApplicationController
  before_filter :authenticate_user!

  def show
    @shopping_list = session[:shopping_list]
  end

  def new
  end

  def create
    ShoppingItems::PrepareShoppingList.call(params[:shopping_list]) do
      on(:ok) do |shopping_list|
        session[:shopping_list] = shopping_list
        flash[:success] = 'Shopping list created'
        redirect_to action: :show
      end
      on(:danger) do
        flash[:danger] = 'Please enter a few items in the shopping list'
        redirect_to action: :new
      end
    end
  end
end
