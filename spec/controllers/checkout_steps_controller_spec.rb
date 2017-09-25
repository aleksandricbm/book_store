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
          expect(@ability).to be_able_to(:admin, User.new)
        end
      end
    end
  end

  context "validations" do
    describe "step/address" do
      subject(:address) {FactoryGirl.create(:shipping_method)}
      it "should validate first name with a 2-35 letter string" do
        ["", "a", "I"].each do |word|
          address.name = word
          expect(address).to_not be_valid
        end
        address.name = "ab"
        expect(address).to be_valid
      end
    end

  end



end
