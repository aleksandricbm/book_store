require 'rails_helper'
RSpec.describe User, type: :model do

  it { should have_one :billing_address }
  it { should have_one :shipping_address }
  it { should have_many :orders }

  let(:user){ FactoryGirl.create(:user) }

  context "when is an account admin" do
    subject(:ability){ Ability.new(user) }
    let(:user){ FactoryGirl.create(:user, role: 'admin') }
    it { should be_able_to(:admin, user.role) }
  end
  context "when is an account guest" do
    subject(:ability){ Ability.new(user) }
    let(:user){ FactoryGirl.create(:user) }
    it { expect(user.role).to be_nil }
  end

  context "validations" do
    before do
      user =  FactoryGirl.create(:user)
    end

    it "requires an email" do
        expect(user).to validate_presence_of(:email)
    end

    it "requires a unique email" do
        expect(user).to validate_uniqueness_of(:email)
    end

    it "requires a unique email (case insensitive)" do
        user.email = "TEST@DOMEN.COM"
        expect(user).to validate_uniqueness_of(:email)
    end

    it "requires the email to look like an email" do
        user.email = "test"
        expect(user).to_not be_valid
    end
  end
end
