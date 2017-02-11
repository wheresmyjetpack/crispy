module Ingredients
  class Repository
    def initialize(relation: Ingredient)
      @relation = relation
    end

    def write(data)
      persist(data)
    end

    def write_with(projection, data)
      write(projection.apply(data))
    end

    def write_collection(data)
      data.each { |d| persist(d) }
    end

    private

    attr_reader :relation

    def persist(data)
      relation.create(**data)
    end
  end
end
