module Users
  class Repository
    include Persistence::RepositoryBase

    source_model User
    commands :create
    
    def initialize(scope)
      @scope = Array(scope)
    end

    def self.create(record)
      registry[:create][record]
    end

    def all
      scoped_model.all
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
