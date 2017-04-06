module Persistence
  module Commands
    class Update
      include Command

      cattr_reader :by_key

      def self.call(record)
        raise Persistence::Errors::LookupKeyError, "The lookup key has not been defined. Do so with #{self}.with_key" if by_key.nil?
        new(record).call
      end

      def self.with_key(pairing)
        @@by_key = pairing
        self
      end

      operations :lookup

      class << self
        alias_method :[], :call
      end
    end
  end
end
