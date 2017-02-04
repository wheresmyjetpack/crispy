module ShoppingItems
  class ListForm < Forms::Immutable
    values do
      attribute :name, String
      attribute :amount, String
    end

    validates :name, :amount, presence: true
  end
end
