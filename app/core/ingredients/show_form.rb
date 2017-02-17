module Ingredients
  class ShowForm < Dry::Struct
    constructor_type :strict

    attribute :name, Types::String
    attribute :amount, Types::ItemMeasurement
  end
end
