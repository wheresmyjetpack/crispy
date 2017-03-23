module Ingredients
  class Repository
    include Persistence::RepositoryBase

    source_model Ingredient

    def initialize(scope: [])
      @scope = Array(scope)
    end

    def all
      scoped_model.all
    end

    def self.command(command, record, **opts)
      command.call(record, opts)
    end

    def self.delete(record)
      model.destroy(record)
    end

    private

    attr_reader :scope

    def scoped_model
      scope.empty? ? model : apply_scope(model)
    end

    def apply_scope(relation)
      scope.inject(relation) { |r, s| s.call(r) }
    end
  end
end
