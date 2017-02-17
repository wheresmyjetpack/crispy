module ShoppingItems
  class ListForm < Dry::Struct
    constructor_type :strict

    attribute :name, String
    attribute :amount, String
  end
end
