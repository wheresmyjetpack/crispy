module ShoppingItems
  class StorageForm < Forms::Immutable
    values do 
      attribute :name, String
      attribute :amount, Measurement
    end
  end
end
