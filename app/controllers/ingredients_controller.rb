class IngredientsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @ingredients = Ingredient.all
  end
end
