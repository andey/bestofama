require 'factory_girl'

FactoryGirl.define do
  factory :ama do
    sequence(:key) { |n| "key#{n}" }
    sequence(:date) { |n| DateTime.now - n.days }
    sequence(:title) { |n| "Title AMA ##{n}" }
    karma Random.rand(100...5000)
    sequence(:permalink) { |n| "http://reddit.com/#{n}" }
    user
  end
end