require 'rails_helper'

RSpec.describe BillingAddress, type: :model do
  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :order }
  it {
    is_expected.to validate_presence_of(:first_name)
    is_expected.to validate_length_of(:first_name).is_at_least(2)
  }
  it {
    is_expected.to validate_presence_of(:last_name)
    is_expected.to validate_length_of(:last_name).is_at_least(2)
  }
  it {
    is_expected.to validate_presence_of(:address)
    is_expected.to validate_length_of(:address).is_at_least(5)
  }
  it {
    is_expected.to validate_presence_of(:city)
    is_expected.to validate_length_of(:city).is_at_least(3)
  }
  it { is_expected.to validate_numericality_of(:zip) }
  it { is_expected.to validate_numericality_of(:phone) }
end
