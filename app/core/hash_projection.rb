class HashProjection
  def initialize(*fields)
    @fields = fields
  end

  def apply(source)
    projection = pluck_to_hash(source)
    return projection unless block_given?
    projection.map { |proj| yield proj }
  end

  def self.for_ingredient
    new(:name, :amount)
  end

  private

  attr_reader :fields

  def pluck_to_hash(source)
    source.pluck_to_hash(*fields).map { |row| row.symbolize_keys }
  end
end
