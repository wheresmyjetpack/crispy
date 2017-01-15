module ShoppingItems
  class PrepareShoppingList < Rectify::Command
    def initialize(shopping_list)
      @shopping_list = shopping_list
    end

    def call
      shopping_list
    end

    private

    attr_reader :shopping_list
  end
end
