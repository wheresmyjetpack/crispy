require 'spec_helper'
require 'core/ingredients/ingredient_form'

describe Ingredients::IngredientForm do
  subject { described_class }

  it { is_expected.to respond_to(:name) }
end
