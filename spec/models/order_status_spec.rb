require 'rails_helper'

RSpec.describe OrderStatus, type: :model do
  it { should have_many :orders }
  it {
    should validate_presence_of(:name)
    should validate_length_of(:name).is_at_least(2)
  }
end
