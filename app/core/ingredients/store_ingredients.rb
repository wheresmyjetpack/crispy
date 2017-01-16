module Ingredients
  class StoreIngredients < Rectify::Command
    def initialize(ingredients, form_type: Ingredients::IngredientForm, relation: Ingredient)
      @form_type = form_type
      @ingredients = ingredients
      @relation = relation
    end

    def call
      build_forms.each do |form|
        create_ingredient(form)
      end
    end

    private

    attr_reader :form_type, :ingredients, :relation

    def create_ingredient(form)
      ingredient = relation.new(name: form.name)
      ingredient.save!
    end

    def build_forms
      ingredients.map { |ingredient| form_type.from_params(ingredient) }
    end
  end
end
