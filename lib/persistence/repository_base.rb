module Persistence
  module RepositoryBase
    extend ActiveSupport::Concern
    mattr_reader :model

    class_methods do
      mattr_reader :registry { {} }

      def commands(*args, **kwargs)
        commands = kwargs.merge(args.map { |arg| [arg, arg] }.to_h)
        commands.each do |command, mapping|
          registry[command] =  "#{self.parent}::Commands::#{command.to_s.camelize}".constantize
        end
      end

      def source_model(model)
        @@model = model
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
