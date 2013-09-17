require 'factory_girl'

FactoryGirl.define do
  factory :ama do
    sequence(:key) { |n| "key#{n}" }
    sequence(:date) { |n| DateTime.now - n.days }
    sequence(:title) { |n| "Title AMA ##{n}" }
    karma 1000
    user_id 1
    sequence(:permalink) { |n| "http://reddit.com/#{n}" }
  end
end