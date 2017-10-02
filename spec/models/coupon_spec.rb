require 'rails_helper'

RSpec.describe Coupon, type: :model do
  it { expect(subject).to have_many :orders }
  it do
    is_expected.to validate_presence_of(:code)
    is_expected.to validate_uniqueness_of(:code)
  end
  it do
    is_expected.to validate_presence_of(:price)
    is_expected.to validate_numericality_of(:price).is_greater_than(1)
  end
end
