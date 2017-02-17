require 'ostruct'

module ShoppingItems
  class PrepareShoppingList < Rectify::Command
    def initialize(shopping_list, form: ShoppingItems::ListForm)
      @shopping_list = transform(shopping_list)
      @form = form
    end

    def call
      item_list = prepared_items
      return broadcast(:invalid) if item_list.empty?
      broadcast(:ok, item_list)
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
