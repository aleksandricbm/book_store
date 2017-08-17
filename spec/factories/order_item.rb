FactoryGirl.define do
  factory :order_item do
    association :book
    association :order
    quantity 1
    price 10
  end
end
