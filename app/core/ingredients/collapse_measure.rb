module Ingredients
  CollapseMeasure = Class.new(Transproc::Transformer[Functions]) do
    map_array do
      symbolize_keys
      nest :measure, [:amount, :unit]
      map_value :measure, -> v { "#{v[:amount]} #{v[:unit]}" }
      map_value :measure, -> v { v.to_measurement.to_s }
    end
  end
end
