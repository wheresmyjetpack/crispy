module Ingredients
  class FetchItems < Rectify::Command
    def initialize(source: Ingredient, projection: Ingredients::CollapseMeasure)
      @source = source
      @projection = projection
    end

    def call
      items = map_to_forms
      return broadcast(:invalid) unless items
      broadcast(:ok, items)
    end

    private

    attr_reader :source, :projection

    def map_to_forms
      project
    end

    def fetch_from_source
      source.all.map { |record| record.serializable_hash }
    end

    def project
      projection.new.call(fetch_from_source)
    end
  end
end
