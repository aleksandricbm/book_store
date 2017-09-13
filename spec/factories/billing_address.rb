require 'ffaker'

FactoryGirl.define do
  factory :billing_address do
    # association :user_id, factory: :user
    # association :order_id, factory: :order
    first_name FFaker::Name.first_name
    last_name FFaker::Name.last_name
    address FFaker::Address.street_address
    city FFaker::Address.country
    zip 49000
    phone 5678945678
  end
end
