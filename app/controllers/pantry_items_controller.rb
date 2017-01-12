class PantryItemsController < ApplicationController
  def index
    @pantry_items = PantryItem.all
  end
end
