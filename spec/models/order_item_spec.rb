require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  it { is_expected.to belong_to :book }
  it { is_expected.to belong_to :order }

  let(:order) { FactoryGirl.create(:order) }
  let(:book) { FactoryGirl.create(:book) }
  let(:order_item) { FactoryGirl.create(:order_item, quantity: 2, price: 5, order_id: order.id) }

  it 'return total price' do
    expect(order_item.item_total_price).to eq 10
  end
  it 'add one book' do
    qty = order_item.quantity
    expect(order_item.add_book(order_item)).to eq (qty + 1)
  end
  it 'remove book' do
    qty = order_item.quantity
    expect(order_item.remove_book(order_item).quantity).to eq (qty - 1)
  end
end
