require 'spec_helper'
require 'core/ingredients/store_ingredients'
require 'core/ingredients/entity'

describe Ingredients::StoreIngredients do
  let(:form_type) { class_double(Ingredients::Entity, new: form_instance) }
  let(:form_instance) { instance_double(Ingredients::Entity, name: 'ingredient name') }
  let(:record) { double('record', save!: nil) }
  let(:relation) { double('relation', new: record) }

  describe '#call' do
    before { described_class.call(ingredients, form_type: form_type, relation: relation) }

    context 'when there are three ingredients' do
      let(:ingredients) { [1, 2, 3] }

      describe 'the form' do
        subject { form_type }

        it { is_expected.to have_received(:new).once.with(1) }
        it { is_expected.to have_received(:new).once.with(2) }
        it { is_expected.to have_received(:new).once.with(3) }
      end

      describe 'the relations' do
        subject { relation }

        it { is_expected.to have_received(:new).exactly(3).times.with({name: form_instance.name}) }
      end

      describe 'the new records from the relations' do
        subject { record }

        it { is_expected.to have_received(:save!).exactly(3).times }
      end
    end
  end
end
