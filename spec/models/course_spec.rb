require 'rails_helper'

RSpec.describe Course, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe 'associations' do
    it 'should have many tutors' do
      association = Course.reflect_on_association(:tutors)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:dependent]).to eq(:destroy)
    end
  end

  describe 'validations' do
    it 'should validates presence of code' do
      course = Course.new(code: nil, name: 'Sample Course')
      course.valid?
      expect(course.errors[:code]).to include("can't be blank")
    end

    it 'should validate presence of name' do
      course = FactoryBot.build(:course, name: nil)
      expect(course.valid?).to eq(false)
      expect(course.errors.messages[:name]).to eq(["can't be blank"])
    end

    it 'should validate uniqueness of code' do
      course = FactoryBot.build(:course, code: 'DSE1')
      expect(course.valid?).to eq(false)
      expect(course.errors.messages[:code]).to eq(['has already been taken'])
    end

    it 'should have the valid factory' do
      expect(FactoryBot.build(:course)).to be_valid
    end

    context 'validate code and course name' do
      context 'when code and course name are present and code is unique' do
        it 'the course should be created successfully' do
          course = FactoryBot.build(:course)
          expect(course.valid?).to eq(true)
        end
      end
    end
  end
end
