module Ingredients
  class Form < Forms::Immutable
    values do
      attribute :name, String
      attribute :amount, Measurement
    end

    validates :name, :amount, presence: true
  end
end
