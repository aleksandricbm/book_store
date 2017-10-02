require 'rails_helper'

RSpec.describe Review, type: :model do
  it { is_expected.to belong_to :book }
  it { is_expected.to belong_to :user }

  it "comment" do
    is_expected.to validate_presence_of(:comment)
    is_expected.to validate_length_of(:comment).is_at_most(500)
  end

  let(:book) { FactoryGirl.create(:book) }
  let(:user) { FactoryGirl.create(:user) }
  let(:review) { FactoryGirl.create(:review, book_id: book.id, user_id: user.id, comment: 'sdfgvhnkdshgnsdh') }
  it "check regexp an comment" do
    expect(review.comment).to match /\A[A-Za-z0-9]+\z/
  end
end
