require 'rails_helper'

RSpec.describe CategoryController, type: :controller do |variable|
  it "find category to not nil" do
    FactoryGirl.create(:category)
    controller.params = ActionController::Parameters.new({ id: 1})
    expect(controller.show).to_not be_nil
  end
end
