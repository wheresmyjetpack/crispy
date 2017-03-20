module ShoppingItems
  class SaveItems < Rectify::Command
    def initialize(items, model: Ingredient, projection: Ingredients::ExpandMeasure)
      @items = items
      @model = model
      @projection = projection
    end

    def call
      forms = project(items)
      return broadcast(:invalid) unless forms
      broadcast(:ok) if create_from(forms)
    end

    private

    attr_reader :items, :model, :projection

    def create_from(forms)
      forms.map do |record|
        existing = model.find_by(name: record.name)
        existing.nil? ? model.create(**record) : update(existing, record)
      end
    end

    def update(existing, record)
      measure = "#{existing.amount} #{existing.unit}".to_measurement
      measure += "#{record.amount} #{existing.unit}".to_measurement
      record = record.to_h.merge(amount: measure.quantity, unit: measure.unit)
      existing.update(**record)
    end

    def project(data)
      projection.new.call(data)
    end
  end
end
