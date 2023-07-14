FactoryBot.define do
  factory :course do
    name { "DSA" }
    sequence(:code) {|n| "CSE-0 #{n}"}
  end
end
