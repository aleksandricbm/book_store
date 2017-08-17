require 'rails_helper'

RSpec.describe Category, type: :model do
  it { expect(subject).to have_many :books }
  it {
    should validate_presence_of(:name)
    should validate_uniqueness_of(:name)
  }
end
