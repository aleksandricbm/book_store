require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  it { should belong_to :book }
  it { should belong_to :order }

  let(:book) { FactoryGirl.create(:book) }
  let(:order_item) { FactoryGirl.create(:order_item, quantity: 2, price: 5) }

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
