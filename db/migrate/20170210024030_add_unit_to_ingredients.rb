class AddUnitToIngredients < ActiveRecord::Migration[5.0]
  def change
    add_column :ingredients, :unit, :string, null: false
  end
end
