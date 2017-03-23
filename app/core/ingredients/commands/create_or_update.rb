module Ingredients
  module Commands
    class CreateOrUpdate
      include Transproc::Composer

      Functions.register(:collapse_measurement) { |v| "#{v.amount} #{v.unit}".to_measurement }

      def initialize(model: Ingredient)
        @model = model
      end

      def call(record, **opts)
        query = lookup.call(model: model, opts: opts)
        return create.call(model: model, record: record) if query.nil?
        update.call(existing: query, new: record)
      end

      private

      attr_reader :model

      def lookup
        t(-> h { h[:model].find_by(**h[:opts]) })
      end

      def create
        t(-> h { h[:model].create(**h[:record]) })
      end

      def update
        compose do |fns|
          fns << t(:copy_keys, {existing: :existing_measure, new: :new_measure})
          fns << t(:map_value, :existing_measure, t(:collapse_measurement))
          fns << t(:map_value, :new_measure, t(:collapse_measurement))
          fns << t(-> h { h[:updated_measure] = h[:new_measure] + h[:existing_measure]; h })
          fns << t(:map_value, :new, -> n { n.to_h })
          fns << t(-> h { h[:new] = h[:new].merge(amount: h[:updated_measure].quantity, unit: h[:updated_measure].unit); h })
          fns << t(:nest, :args, [:existing, :new])
          fns << t(:map_value, :args, -> h { h[:existing].update(h[:new]) })
          fns << t(:rename_keys, args: :success)
        end
      end

      def t(*args)
        Functions[*args]
      end
    end
  end
end
