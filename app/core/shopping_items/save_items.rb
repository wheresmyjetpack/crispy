module ShoppingItems
  class SaveItems < Rectify::Command
    def initialize(items, relation: Ingredients::Repository, projection: Ingredients::PrepareForCreate.new)
      @items = items
      @relation = relation
      @projection = projection
    end

    def call
      forms = project(items)
      return broadcast(:invalid) unless forms
      broadcast(:ok) if create_from(forms)
    end

    private

    attr_reader :items, :relation, :projection

    def create_from(forms)
      forms.map { |record| relation.upsert(record) }
    end

    def project(data)
      projection.call(data)
    end
  end
end
