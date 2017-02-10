module ShoppingItems
  class SaveItems < Rectify::Command
    def initialize(items, persist_action: Ingredients::StoreIngredients, form: Ingredients::Form)
      @items = items
      @persist_action = persist_action
      @form = form
    end

    def call
      persists = items.map { |name, amount| form.new(name: name, amount: amount) }
      persist_action.call(persists)
    end

    private

    attr_reader :items, :persist_action, :form
  end
end
