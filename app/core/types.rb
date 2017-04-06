module Types
  include Dry::Types.module

  ItemMeasurement = String.constrained(format: /(\d+|\d+\.?\d+) \w+\.?$/)
  Email = String.constrained(format: /[\w\d\-_.]+?@[a-z\d\-.]+?(?<!\.)\.[a-z]+/i)
end
