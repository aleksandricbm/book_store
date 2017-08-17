require 'rails_helper'

RSpec.describe Order, type: :model do

  let(:order) { FactoryGirl.create(:order) }

  before(:example) do
    order.order_items = [FactoryGirl.build(:order_item, price: 10.00, quantity: 2)]
  end

  it { should have_many(:books).through(:order_items) }
  it { should have_many(:order_items) }

  it 'order total_price' do
    expect(order.total_price).to eq 20
  end

  it 'order total with discount' do
    order.coupon = FactoryGirl.create(:coupon, price: 10.00)
    expect(order.order_total).to eq 10
  end

  it 'retrun discount' do
    order.coupon = FactoryGirl.create(:coupon, price: 25.00)
    expect(order.discount).to eq 25
  end

  it 'get quantity order_items' do
    expect(order.total_quantity).to eq 2
  end
 end
