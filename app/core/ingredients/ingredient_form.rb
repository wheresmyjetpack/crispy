module Ingredients
  class IngredientForm < Rectify::Form
    attribute :name, String

    validates :name, presence: true
  end
end
