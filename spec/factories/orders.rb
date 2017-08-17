FactoryGirl.define do
  factory :order do
    sequence(:order)  { |y| FFaker::Book.title + y.to_s }
    total_price 10
  end

  # factory :order_item do

  # end

end
