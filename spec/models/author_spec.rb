require "rails_helper"

 describe Author, type: :model do
  it { expect(subject).to have_and_belong_to_many :books }
  it { expect(subject).to validate_uniqueness_of :name }
  it { expect(subject).to validate_presence_of :name }
 end

