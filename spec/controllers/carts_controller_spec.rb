require 'rails_helper'

RSpec.describe CartsController, type: :controller do |variable|
  describe "GET #show" do
    before { get :show }

    it "return http success for render template" do
      expect(response).to have_http_status(200)
      expect(response).to render_template('show')
    end

    it "order_items not be nil" do
      expect(assigns(:order_items)).to_not be_nil
    end
  end

  describe "POST #update" do
    it "redirect_to cart_path - success" do
      post :update
      expect(response).to redirect_to cart_path
    end

    it "correct coupon" do
      coupon = FactoryGirl.create(:coupon)
      post :update, params: { coupon: coupon.code }
      expect(assigns(:coupon)).not_to be_nil
      expect(assigns(:coupon).id).to eq coupon.id
      expect(response).to redirect_to cart_path
    end
    it "correct coupon" do
      post :update, params: { coupon: 'nil' }
      expect(assigns(:coupon)).to be_nil
      expect(response).to redirect_to cart_path
    end
  end
end
