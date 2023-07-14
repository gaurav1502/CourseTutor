require 'rails_helper'

RSpec.describe Tutor, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe 'associations' do
    it 'should have belong to course' do
      tutors_relation = described_class.reflect_on_association(:course)
      expect(tutors_relation.macro).to eq(:belongs_to)
    end
  end

  describe 'validation' do
    context 'when name is nil' do
      it 'should be required presence name' do
        tutor = FactoryBot.build(:tutor, name: nil)
        expect(tutor.valid?).to eq(false)
        expect(tutor.errors.messages[:name]).to include("can't be blank")
      end
    end

    context 'when contact number is nil' do
      it 'should be presence of contact number' do
        tutor = FactoryBot.build(:tutor, contact_number: nil)
        expect(tutor.valid?).to eq(false)
        expect(tutor.errors.messages[:contact_number]).to include("can't be blank")
      end
    end

    context 'when course is not present for tutor' do
      it 'requires a course to be valid' do
        tutor = FactoryBot.build(:tutor, name: 'Gaurav', course: nil)
        expect(tutor).not_to be_valid
      end
    end

    context 'when contact_number is not unique' do
      let!(:existing_tutor) { FactoryBot.create(:tutor, name: 'Gaurav', contact_number: '9090909901') }

      it 'should not be valid' do
        tutor = FactoryBot.build(:tutor, name: 'Gaurav', contact_number: '9090909901')
        expect(tutor).not_to be_valid
        expect(tutor.errors[:contact_number]).to include('has already been taken')
      end
    end
  end
end
