FactoryGirl.define do
  factory :user do
    email {FFaker::Internet.email}
    password 'aq4Awsedvgty'
    password_confirmation 'aq4Awsedvgty'
  end
end
