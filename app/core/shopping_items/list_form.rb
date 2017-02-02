module ShoppingItems
  class ListForm
    include Virtus.value_object

    values do
      attribute :name, String
      attribute :amount, String
    end
  end
end
