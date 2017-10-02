require 'rails_helper'

RSpec.describe ShippingAddress, type: :model do
  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :order }

  it "first_name" do
    is_expected.to validate_presence_of(:first_name)
    is_expected.to validate_length_of(:first_name).is_at_least(2)
  end

  it "last_name" do
    is_expected.to validate_presence_of(:last_name)
    is_expected.to validate_length_of(:last_name).is_at_least(2)
  end

  it "address" do
    is_expected.to validate_presence_of(:address)
    is_expected.to validate_length_of(:address).is_at_least(5)
  end

  it "city" do
    is_expected.to validate_presence_of(:city)
    is_expected.to validate_length_of(:city).is_at_least(3)
  end

  it { is_expected.to validate_numericality_of(:zip) }
  it { is_expected.to validate_numericality_of(:phone) }
end
