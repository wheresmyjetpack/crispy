require 'spec_helper'
require 'core/ingredients/entity'

describe Ingredients::Entity do
  let(:name) { 'milk' }
  let(:amount) { 1 }
  let(:unit) { 'gal' }
  let(:form) { {name: name, amount: amount, unit: unit} }

  describe 'a hyrdated entity' do
    subject { described_class.new(form) }

    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:amount) }
    it { is_expected.to respond_to(:unit) }
  end
end
