module Ingredients
  class Form < Forms::Immutable
    values do
      attribute :name, String
      attribute :amount, Measurement
    end

    validates :name, presence: true
  end
end
