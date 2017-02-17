module Types
  include Dry::Types.module

  ItemMeasurement = Types::String.constrained(format: /(\d+|\d+\.?\d+) \w+\.?$/)
end
