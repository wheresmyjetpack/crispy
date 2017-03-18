class IngredientsController < ApplicationController
  before_action :authenticate_user!

  def index
    @ingredients = Ingredient.all
  end

  def create
    Ingredients::StoreIngredients.call(params[:ingredients]) do
      on(:ok) { redirect_to ingredients_path }
    end
  end
end
