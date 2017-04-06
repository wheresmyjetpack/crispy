module Persistence
  module Commands
    class Create
      include Command

      operations :create

      def self.call(record)
        new(record).call
      end

      class << self
        alias_method :[], :call
      end
    end
  end
end
