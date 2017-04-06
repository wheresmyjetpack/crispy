require 'transproc/all'

module Operations
  extend Transproc::Registry

  import Transproc::ArrayTransformations
  import Transproc::HashTransformations
  import Transproc::ClassTransformations

  def self.lookup(hash)
    hash.fetch(:model).find_by(hash.fetch(:by_key))
  end

  def self.create(hash)
    hash.fetch(:model).create(**hash.fetch(:record))
  end

  def self.collapse_measurement(measure)
    "#{measure.amount} #{measure.unit}".to_measurement
  end

  def self.explode_measurement(measure)
    {amount: measure.quantity, unit: measure.unit}
  end

  def self.map_value_to_hash(hash, key)
    hash.merge(key => hash[key].to_h)
  end
end
