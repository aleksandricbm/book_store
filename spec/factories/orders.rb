FactoryGirl.define do
  factory :order do
    sequence(:number)  { |y| FFaker::Book.title + y.to_s }
    total_price 10
  end
end
