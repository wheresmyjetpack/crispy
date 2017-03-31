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

      private

      attr_reader :model, :record
    end
  end
end
