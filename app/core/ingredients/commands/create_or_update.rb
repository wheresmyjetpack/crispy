module Ingredients
  module Commands
    class CreateOrUpdate
      include Transproc::Composer
      cattr_reader :by_key

      def initialize(record, model, **opts)
        @record = record
        @model = model
        @opts = opts
      end

      def call
        query = lookup.call(model: model, by_key: by_key)
        return create.call(model: model, record: record) if query.nil?
        update.call(existing: query, new: record)
      end

      def self.call(record, model= Ingredient, **opts)
        raise RelationKeyError, "The lookup key has not been defined by. Do so with #{self}.with_key" if by_key.nil?
        new(record, model, opts).call
      end

      def self.with_key(pairing)
        @@by_key = pairing
        self
      end

      private

      attr_reader :record, :model, :opts

      def lookup
        t(:lookup)
      end

      def create
        t(:create)
      end

      def update
        [calc_measurements, update_measurements].reduce(:>>)
      end

      def update_measurements
        compose do |ops|
          ops << t(:map_value_to_hash, :new)
          ops << t(-> h { h.merge(new: h[:new].merge(h[:updated_measure]) )})
          ops << t(:nest, :args, [:existing, :new])
          ops << t(:map_value, :args, -> h { h[:existing].update(h[:new]) })
          ops << t(:rename_keys, args: :success)
        end
      end

      def calc_measurements
        compose do |ops|
          ops << t(:copy_keys, {existing: :existing_measure, new: :new_measure})
          ops << t(:map_value, :existing_measure, t(:collapse_measurement))
          ops << t(:map_value, :new_measure, t(:collapse_measurement))
          ops << t(-> h { h.merge(updated_measure: h[:new_measure] + h[:existing_measure]) })
          ops << t(:map_value, :updated_measure, t(:explode_measurement))
          ops << t(:reject_keys, [:existing_measure, :new_measure])
        end
      end

      def t(*args)
        Operations[*args]
      end
      class RelationKeyError < StandardError; end
    end
  end
end
