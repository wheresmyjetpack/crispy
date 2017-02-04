module Forms
  class Immutable
    include Virtus.value_object
    include ActiveModel::Validations
  end
end
