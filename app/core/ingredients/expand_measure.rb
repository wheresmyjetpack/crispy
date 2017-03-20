module Ingredients
  ExpandMeasure = Class.new(Transproc::Transformer[Functions]) do
    map_array do
      symbolize_keys
      map_value :amount, -> v { v.to_measurement }
      copy_keys amount: :unit
      map_value :amount, -> v { v.quantity }
      map_value :unit, -> v { v.unit }
      constructor_inject Ingredients::Entity
    end
  end
end
