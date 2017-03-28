module Persistence
  module Commands
    class Update
      include Transproc::Composer

      cattr_reader :by_key

      def op(*args)
        Operations[*args]
      end

      def operation(&block)
        compose(&block)
      end

      def self.chain_ops(ops)
        ops.each do |name, op_list|
          define_method(name) do
            op_list.map { |op| send(op) }.reduce(:>>)
          end
        end
      end

      def self.operations(*ops)
        ops.each do |o|
          define_method(o) do
            op(o)
          end
        end
      end

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
