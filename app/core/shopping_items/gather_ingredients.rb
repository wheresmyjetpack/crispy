module ShoppingItems
  class GatherIngredients
    def initialize(ingredients)
      @ingredients = ingredients
    end

    def call
      ingredients.map do |ingredient, _|
        {name: ingredient}
      end
    end

    def self.call(ingredients)
      new(ingredients).call
    end

    private 

    attr_reader :ingredients
  end
end
