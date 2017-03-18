module Ingredients
  class Entity < Forms::Immutable
    values do
      attribute :name, String
    end

    validates :name, presence: true
  end
end
