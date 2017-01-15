class RenamePantryItemsToIngredients < ActiveRecord::Migration[5.0]
  def change
    rename_table :pantry_items, :ingredients
  end
end
