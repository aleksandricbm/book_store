require 'rails_helper'

RSpec.describe Coupon, type: :model do
  it { expect(subject).to have_many :orders }
end
