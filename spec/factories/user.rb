require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "factory_username_#{n}" }
  end
end