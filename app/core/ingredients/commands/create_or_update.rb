module Ingredients
  module Commands
    class CreateOrUpdate < Persistence::Commands::Update
      chain_ops update: [:calc_measurements, :update_measurements]

      def initialize(record, model: Ingredient)
        @record = record
        @model = model
      end

      def call
        query = lookup.call(model: model, by_key: by_key)
        return create.call(model: model, record: record) if query.nil?
        update.call(existing: query, new: record)
      end

      private

      attr_reader :record, :model

      def lookup
        op(:lookup)
      end

      def create
        op(:create)
      end

      def update_measurements
        compose do |ops|
          ops << op(:map_value_to_hash, :new)
          ops << op(-> h { h.merge(new: h[:new].merge(h[:updated_measure]) )})
          ops << op(:nest, :args, [:existing, :new])
          ops << op(:map_value, :args, -> h { h[:existing].update(h[:new]) })
          ops << op(:rename_keys, args: :success)
        end
      end

      def calc_measurements
        compose do |ops|
          ops << op(:copy_keys, {existing: :existing_measure, new: :new_measure})
          ops << op(:map_value, :existing_measure, op(:collapse_measurement))
          ops << op(:map_value, :new_measure, op(:collapse_measurement))
          ops << op(-> h { h.merge(updated_measure: h[:new_measure] + h[:existing_measure]) })
          ops << op(:map_value, :updated_measure, op(:explode_measurement))
          ops << op(:reject_keys, [:existing_measure, :new_measure])
        end
      end
    end
  end
end
