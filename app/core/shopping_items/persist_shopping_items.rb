module ShoppingItems
  class PersistShoppingItems
    def initialize(items, sort_action: ShoppingItems::GatherIngredients,
                   persist_action: Ingredients::StoreIngredients)
      @items = items
      @sort_action = sort_action
      @persist_action = persist_action
    end

    def call
      persists = sort_action.call(items)
      persist_action.call(persists)
    end

    def self.call(items)
      new(items).call
    end

    private

    attr_reader :items, :sort_action, :persist_action
  end
end
