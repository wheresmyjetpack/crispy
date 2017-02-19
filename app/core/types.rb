module Types
  include Dry::Types.module

  ItemMeasurement = String.constrained(format: /(\d+|\d+\.?\d+) \w+\.?$/)
end
