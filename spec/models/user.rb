require 'rails_helper'
RSpec.describe User, type: :model do

  it { is_expected.to have_one :billing_address }
  it { is_expected.to have_one :shipping_address }
  it { is_expected.to have_many :orders }

  let(:user){ FactoryGirl.create(:user) }

  it "requires a password" do
    expect(user.password).to match /^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).{8,}$/
  end

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
    it "reqexp email" do
      expect(:email).to match /\A(?!.*\.\.)(?!.*\-\-)^(?!\.)([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
    end

    it "requires length and hyphen" do
      expect(user).to ensure_length_of(:email).is_at_most(63)
    end

    it "requires an email" do
      expect(user).to validate_presence_of(:email)
    end

    it "requires a unique email" do
      expect(user).to validate_uniqueness_of(:email)
    end

    it "requires a unique email (case insensitive)" do
      user.email = "TEST@DOMEN.COM"
      expect(user).to_not validate_uniqueness_of(:email)
    end

    it "requires the email to look like an email" do
      user.email = "test"
      expect(user).to_not be_valid
    end
  end
end
