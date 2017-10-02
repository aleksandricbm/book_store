require "rails_helper"

RSpec.describe Ability, type: :controller do

  describe "can not manag" do
    let(:user) { FactoryGirl.create(:user) }
    let(:ability) { Ability.new(user) }

    it "BillingAddress" do
      assert ability.can?(:read, BillingAddress.new(user_id: user.id))
      assert ability.cannot?(:destroy, BillingAddress.new)
    end

    it "Order" do
      assert ability.can?(:read, Order.new(user_id: user.id))
      assert ability.cannot?(:read, Order.new)
    end

    it "Book" do
      assert ability.can?(:read, Book.new)
      assert ability.cannot?(:create, Book.new)
    end

    it "BillingAddress" do
      assert ability.can?(:read, BillingAddress.new(user_id: user.id))
      assert ability.cannot?(:read, BillingAddress.new)
      assert ability.can?(:create, BillingAddress.new(user_id: user.id))
      assert ability.cannot?(:create, BillingAddress.new)
      assert ability.can?(:update, BillingAddress.new(user_id: user.id))
      assert ability.cannot?(:update, BillingAddress.new)
    end

    it "ShippingAddress" do
      assert ability.can?(:read, ShippingAddress.new(user_id: user.id))
      assert ability.cannot?(:read, ShippingAddress.new)
      assert ability.can?(:create, ShippingAddress.new(user_id: user.id))
      assert ability.cannot?(:create, ShippingAddress.new)
      assert ability.can?(:update, ShippingAddress.new(user_id: user.id))
      assert ability.cannot?(:update, ShippingAddress.new)
    end
  end

  describe "can manag" do
    let(:user) { FactoryGirl.create(:user, role: 'admin') }
    let(:ability) { Ability.new(user) }

    it "BillingAddress" do
      assert ability.can?(:read, BillingAddress.new)
      assert ability.can?(:destroy, BillingAddress.new)
    end

    it "Order" do
      assert ability.can?(:read, Order.new)
    end

    it "Book" do
      assert ability.can?(:read, Book.new)
      assert ability.can?(:create, Book.new)
    end

    it "BillingAddress" do
      assert ability.can?(:read, BillingAddress.new)
      assert ability.can?(:create, BillingAddress.new)
      assert ability.can?(:update, BillingAddress.new)
    end

    it "ShippingAddress" do
      assert ability.can?(:read, ShippingAddress.new)
      assert ability.can?(:create, ShippingAddress.new)
      assert ability.can?(:update, ShippingAddress.new)
    end
  end
end
