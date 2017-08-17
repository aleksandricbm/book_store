require 'ffaker'

FactoryGirl.define do
  factory :book do
    sequence(:name)  { |y| FFaker::Book.title + y.to_s }
    price 8.00
    description FFaker::Book.description
    height 2.0
    weight 3.0
    depth 1.5
    material FFaker::Book.genre
    association :category
  end
end
