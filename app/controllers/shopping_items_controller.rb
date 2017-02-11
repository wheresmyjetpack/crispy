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
    shopping_items = params[:ingredients].map(&:to_hash)
    ShoppingItems::SaveItems.call(shopping_items) do
      on(:ok) do
        destroy_shopping_list
        flash[:success] = 'Your items have been stored in the pantry'
      end
      on(:invalid) { flash[:danger] = 'There was an error saving your items' }
    end

    redirect_to ingredients_path
  end

  protected

  def destroy_shopping_list
    session.delete(:shopping_list)
  end
end
