module ShoppingItems
  class PrepareShoppingList < Rectify::Command
    def initialize(shopping_list)
      @shopping_list = shopping_list
    end

    def call
      if prepared_items.empty?
        broadcast(:danger)
      else
        broadcast(:ok, prepared_items)
      end
    end

    private

    attr_reader :shopping_list

    def prepared_items
      shopping_list.reject(&:blank?)
    end
  end
end
