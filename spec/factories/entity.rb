FactoryGirl.define do
  factory :entity do
    sequence(:name) { |n| "entity#{n}" }
    sequence(:slug) { |n| "entity#{n}" }
  end
end