require 'factory_girl'

FactoryGirl.define do
  factory :upcoming do
    sequence(:title) { |n| "John Doe #{n}" }
    description 'Description of upcoming'
    sequence(:date) { |n| DateTime.now + n.days }
    sequence(:url) {|n| "http://url.com/#{n}" }
  end
end