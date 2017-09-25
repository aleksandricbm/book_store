require 'rails_helper'

RSpec.describe OrderItemsController, type: :controller do |variable|
  FactoryGirl.create(:user)

  before {
    @order = FactoryGirl.create(:with_all_data)
    session[:order_id] = @order.id
  }

  context "create" do
    it "return increase quantity book" do
      post :create, params: { order_item: { quantity: 1, book_id: @order.order_items.first.book_id } }
      expect(assigns(:item).quantity).to  eq 2
    end

    it "return order_item new" do
      FactoryGirl.create(:book)
      post :create, params: { order_item: { quantity: 1, book_id: Book.last.id } }
      expect(assigns(:item).quantity).to  eq 1
    end
  end

  context "destroy" do
    it "destroy item" do
      qt = @order.total_quantity
      delete :destroy,  params: { id: @order.order_items.first.id }
      expect(assigns(:order).total_quantity).to eq (qt-1)
      expect(response).to redirect_to cart_path
    end
  end

  it "find_item" do
    controller.params = ActionController::Parameters.new({ id: @order.order_items.first.id})
    expect(controller.instance_eval{find_item}).not_to be_nil
  end

  context "redirect_cart" do

  end

  context "find_order" do

  end
end
