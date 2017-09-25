require 'rails_helper'

RSpec.describe CatalogController, type: :controller do |variable|
  describe "GET #show" do
    before { get :show }
    it "return http success for render template" do
      expect(response).to be_success
      expect(response).to render_template('show')
    end

    it "count_book_in_category not be nil" do
      expect(assigns(:count_book_in_category)).to_not be_nil
    end
  end

  it "private count_book_in_category not be nil" do
    FactoryGirl.create(:category)
    FactoryGirl.create(:book)
    expect(controller.instance_eval{count_book_in_category}).to_not be_nil
  end

  it "private list_catalog not be nil" do
    FactoryGirl.create(:category)
    FactoryGirl.create(:book)
    expect(controller.instance_eval{list_catalog}).to_not be_nil
  end

  it "private sort (newest))" do
    controller.params = ActionController::Parameters.new({ sort: :newest , page: 1})
    expect(controller.instance_eval{sort}).to be_nil
  end
end
