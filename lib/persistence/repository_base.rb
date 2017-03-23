module Persistence
  module RepositoryBase
    extend ActiveSupport::Concern
    mattr_reader :model do
      raise NoModelError, "Data model not set for #{to_s}"
    end

    class_methods do
      def source_model(model)
        @@model = model
      end

      def merge_strategies(*strats)
        strats.flatten.map do |strat|

        end
      end

      def fetch(*args)
        new(scope: args).all
      end

      def model
        @@model
      end
    end
  end
end
