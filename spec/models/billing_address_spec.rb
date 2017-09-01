require 'rails_helper'

RSpec.describe BillingAddress, type: :model do
  it { should belong_to :user }
  it { should belong_to :order }
  it {
    should validate_presence_of(:first_name)
    should validate_length_of(:first_name).is_at_least(2)
  }
  it {
    should validate_presence_of(:last_name)
    should validate_length_of(:last_name).is_at_least(2)
  }
  it {
    should validate_presence_of(:address)
    should validate_length_of(:address).is_at_least(5)
  }
  it {
    should validate_presence_of(:city)
    should validate_length_of(:city).is_at_least(3)
  }
  it { should validate_numericality_of(:zip) }
  it { should validate_numericality_of(:phone) }
end
