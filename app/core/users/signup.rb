module Users
  class Signup < Rectify::Command
    def initialize(params, relation: Users::Repository, projection: PrepareForCreate)
      @params = params
      @relation = relation
      @projection = projection
    end

    def call
      result =  project(user).validate
      return broadcast(:invalid, result.messages) if result.failure?
      
      form = project(result.to_h)
      broadcast(:ok) if create_from(form)
    end

    private

    attr_reader :params, :relation, :projection, :validator

    def user
      params.fetch(:user)
    end

    def create_from(form)
      relation.create(form)
    end

    def project(data)
      projection.new.call(data)      
    end
  end
end
