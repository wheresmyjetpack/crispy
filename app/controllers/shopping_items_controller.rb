class ShoppingItemsController < ApplicationController
  before_action :authenticate_user!

  def show
    @shopping_list = session[:shopping_list]
    redirect_to action: :new if @shopping_list.nil?
  end

  def new
    redirect_to action: :show unless session[:shopping_list].nil?
  end

  def create
    ShoppingItems::PrepareShoppingList.call(params[:shopping_list]) do
      on(:ok) do |shopping_list|
        session[:shopping_list] = shopping_list
        flash[:success] = 'Shopping list created'
        redirect_to action: :show
      end
      on(:invalid) do
        flash[:danger] = 'Please enter a few items in the shopping list'
        render 'new'
      end
    end
  end

  def destroy
    destroy_shopping_list
    redirect_to action: :new
  end

  def persist
    raise 'h'
    ShoppingItems::SaveItems.call(params[:ingredients])
    destroy_shopping_list
    redirect_to ingredients_path
  end

  protected

  def destroy_shopping_list
    session.delete(:shopping_list)
  end
end
