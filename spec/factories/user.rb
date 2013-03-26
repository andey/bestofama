FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "username#{n}" }
    modhash ''
    active true
    comment_karma 0
    link_karma 0
  end
end