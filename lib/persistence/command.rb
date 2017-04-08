module Persistence
  module Command
    extend ActiveSupport::Concern

    def op(*args)
      Operations[*args]
    end

    def operation(&block)
      compose(&block)
    end

    included do
      include Transproc::Composer
    end

    class_methods do
      def call(record)
        new(record).call
      end

      def chain_ops(ops)
        ops.each do |name, op_list|
          define_method(name) do
            op_list.map { |op| send(op) }.reduce(:>>)
          end
        end
      end

      def operations(*ops)
        ops.each do |o|
          define_method(o) do
            op(o)
          end
        end
      end

      alias_method :[], :call
    end

    private

    attr_reader :record, :model
  end
end
