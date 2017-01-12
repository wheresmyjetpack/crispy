class CreatePantryItems < ActiveRecord::Migration[5.0]
  def change
    create_table :pantry_items do |t|
      t.string :name, null: false
      t.timestamps
    end
  end
end
