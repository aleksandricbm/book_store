FactoryGirl.define do
  factory :category do
    sequence(:name)  { |y| FFaker::Book.title + y.to_s }
  end
end
