FactoryGirl.define do
  factory :user do
    email {FFaker::Internet.email}
    password 'qaswedfr'
    password_confirmation 'qaswedfr'
  end
end
