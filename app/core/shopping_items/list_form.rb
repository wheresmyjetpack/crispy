module ShoppingItems
  class ListForm
    include Virtus.value_object
    include ActiveModel::Validations

    values do
      attribute :name, String
      attribute :amount, String
    end

    validates :name, :amount, presence: true
  end
end
