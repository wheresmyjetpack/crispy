require 'ostruct'

module ShoppingItems
  class PrepareShoppingList < Rectify::Command
    def initialize(shopping_list, form: ShoppingItems::ListForm)
      @shopping_list = transform(shopping_list)
      @form = form
    end

    def call
      return broadcast(:invalid) if prepared_items.empty?
      broadcast(:ok, prepared_items)
    end

    private

    attr_reader :shopping_list, :form

    def prepared_items
      shopping_list.map do |item|
        form.new(amount: item.amount, name: item.name) unless item.name.blank?
      end.compact
    end

    def transform(collection)
      # _ is currently a throw-away id generated in the view for uniqueness
      collection.map { |_, item| OpenStruct.new(item) }
    end
  end
end
