FactoryGirl.define do
  factory :order_item do
    association :book
    association :order_id, factory: :order
    quantity 1
    price 10
  end
end
