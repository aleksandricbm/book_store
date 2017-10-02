require 'rails_helper'

RSpec.describe Country, type: :model do
  it "name country" do
    is_expected.to validate_presence_of(:name)
    is_expected.to validate_uniqueness_of(:name)
  end
end
