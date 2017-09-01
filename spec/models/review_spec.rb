require 'rails_helper'

RSpec.describe Review, type: :model do
  it { should belong_to :book }
  it { should belong_to :user }
  it {
    should validate_presence_of(:comment)
    should validate_length_of(:comment).is_at_most(500)
  }

  let(:book) { FactoryGirl.create(:book) }
  let(:user) { FactoryGirl.create(:user) }
  let(:review) { FactoryGirl.create(:review, book_id: book.id, user_id: user.id, comment: 'sdfgvhnkdshgnsdh') }
  it "check regexp an comment" do
    expect(review.comment).to match /\A[A-Za-z0-9]+\z/
  end
end
