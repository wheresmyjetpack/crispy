module Users
  module Commands
    class Create < Persistence::Commands::Create
      def initialize(record, model: User)
        @record = record
        @model = model
      end

      def call
        create.call(model: model, record: record)
      end
    end
  end
end
