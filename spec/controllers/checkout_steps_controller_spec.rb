require 'rails_helper'
require "cancan/matchers"

RSpec.describe CheckoutStepsController, type: :controller do

  describe "Authorizations" do
    context "User is an Admin" do
      before(:each) do
        @user = FactoryGirl.create(:user, role: 'admin')
        @ability = Ability.new(@user)
      end
      describe "should allow management of users" do
        it "should allow management of users" do
          binding.pry
          expect(@ability).to be_able_to(:admin, User.new)
        end
      end
    end
  end

end
