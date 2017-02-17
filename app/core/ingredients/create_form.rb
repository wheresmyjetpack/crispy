module Ingredients
  class CreateForm < Dry::Struct
    constructor_type :strict

    attribute :name, Types::String
    attribute :amount, Types::Int
    attribute :unit, Types::String
  end
end
