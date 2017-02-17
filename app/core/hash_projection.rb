class HashProjection
  def initialize(*fields)
    @fields = fields
  end

  def project(source)
    projection = pluck_to_hash(source)
    block_given? ? projection.map { |proj| yield proj } : projection
  end

  def self.for_ingredient
    new(:name, :amount)
  end

  alias_method :apply, :project

  private

  attr_reader :fields

  def pluck_to_hash(source)
    source.pluck_to_hash(*fields).map { |row| row.symbolize_keys }
  end
end
