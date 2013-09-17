require 'factory_girl'

FactoryGirl.define do
  factory :upcoming do
    sequence(:title) { |n| "John Doe #{n}" }
    description 'Description of upcoming'
    date { DateTime.now }
    sequence(:url) {|n| "http://url.com/#{n}" }
  end
end