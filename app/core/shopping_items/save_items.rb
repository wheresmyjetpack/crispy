module ShoppingItems
  class SaveItems < Rectify::Command
    def initialize(items, relation: Ingredients::Repository, projection: Ingredients::ExpandMeasure,
                   command: Ingredients::Commands::CreateOrUpdate)
      @items = items
      @relation = relation
      @projection = projection
      @command = command
    end

    def call
      forms = project(items)
      return broadcast(:invalid) unless forms
      broadcast(:ok) if create_from(forms)
    end

    private

    attr_reader :items, :relation, :projection, :command

    def create_from(forms)
      forms.map do |record|
        relation.command(command, record, name: record.name)
      end
    end

    def project(data)
      projection.new.call(data)
    end
  end
end
