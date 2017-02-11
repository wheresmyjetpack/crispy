class AddAmountToIngredients < ActiveRecord::Migration[5.0]
  def change
    add_column :ingredients, :amount, :decimal, precision: 8, scale: 4, null: false
  end
end
