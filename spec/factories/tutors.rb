FactoryBot.define do
  factory :tutor do
    name {'test-tutor'}
    sequence(:contact_number) { |n| "9#{n}909012#{n}#{n}" }
    course
  end
end
