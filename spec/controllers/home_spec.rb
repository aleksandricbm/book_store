require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  before { get :home }
  describe "index page" do
    it "#index" do
      expect(response).to render_template(:home)
      expect(response).to have_http_status(200)
    end

    it "bestsellers not nil" do
      expect(response).to render_template partial: 'home/_best_sellers.haml', locals: { bestsellers: @bestsellers }
      expect(assigns(:bestsellers)).not_to be_nil
      expect(response).to have_http_status(200)
    end

    it "carousel not nil" do
      expect(response).to render_template partial: 'home/_carousel.haml', locals: { latests: @latests }
      expect(assigns(:latests)).not_to be_nil
      expect(response).to have_http_status(200)
    end
  end
end
