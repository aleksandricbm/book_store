FactoryGirl.define do
  factory :order do
    total_price 10
    shipping_method
    factory :with_all_data do
      after(:create) do |order|
        create_list :book, 4
        create_list :shipping_address, 1, order_id: order.id, user_id: User.last.id
        create_list :billing_address, 1, order_id: order.id, user_id: User.last.id
        create_list :order_item, 1, order_id: order.id
        create_list :credit_card, 1, order_id: order.id
      end
    end
  end
end
