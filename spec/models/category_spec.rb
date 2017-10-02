require 'rails_helper'

RSpec.describe Category, type: :model do
  it { expect(subject).to have_many :books }
  it "name category" do
    is_expected.to validate_presence_of(:name)
    is_expected.to validate_uniqueness_of(:name)
  end
end
