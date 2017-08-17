require 'rails_helper'

RSpec.describe Coupon, type: :model do
  it { expect(subject).to have_many :orders }
  it {
    should validate_presence_of(:code)
    should validate_uniqueness_of(:code)
  }
  it {
    should validate_presence_of(:price)
    should validate_numericality_of(:price).is_greater_than(1)
  }
end
