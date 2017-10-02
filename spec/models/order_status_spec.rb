require 'rails_helper'

RSpec.describe OrderStatus, type: :model do
  it { is_expected.to have_many :orders }
  it "name" do
    is_expected.to validate_presence_of(:name)
    is_expected.to validate_length_of(:name).is_at_least(2)
  end
end
