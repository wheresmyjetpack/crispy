require 'spec_helper'
require 'core/ingredients/entity'

describe Ingredients::Entity do
  subject { described_class }

  it { is_expected.to respond_to(:name) }
end
