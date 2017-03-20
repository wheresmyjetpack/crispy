class IngredientsController < ApplicationController
  include Rectify::ControllerHelpers

  before_action :authenticate_user!

  def index
    Ingredients::FetchItems.call do
      on(:ok) do |ingredients|
        expose(ingredients: ingredients)
      end
    end
  end

  def create
    Ingredients::StoreIngredients.call(params[:ingredients]) do
      on(:ok) { redirect_to ingredients_path }
    end
  end
end
