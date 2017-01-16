class IngredientsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @ingredients = Ingredient.all
  end

  def create
    Ingredients::StoreIngredients.call(params[:ingredients])
    redirect_to(action: :index)
  end
end
