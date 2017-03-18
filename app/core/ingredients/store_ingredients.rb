module Ingredients
  class StoreIngredients < Rectify::Command
    def initialize(ingredients, form_type: Ingredients::Entity, relation: Ingredient)
      @form_type = form_type
      @ingredients = ingredients
      @relation = relation
    end

    def call
      build_forms.each do |form|
        create_ingredient(form.to_h)
      end
      broadcast(:ok)
    end

    private

    attr_reader :form_type, :ingredients, :relation

    def create_ingredient(form)
      ingredient = relation.new(**form)
      ingredient.save!
    end

    def build_forms
      ingredients.map { |ingredient| form_type.new(ingredient) }
    end
  end
end
