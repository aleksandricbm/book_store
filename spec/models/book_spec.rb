require "rails_helper"

describe Book, type: :model do
  it { expect(subject).to have_and_belong_to_many :authors }
  it { expect(subject).to belong_to :categories }


end

 # describe Book do
 #   it { expect(book).to validate_presence_of(:email) }
 #   it { expect(book).to validate_uniqueness_of(:email) }
 #   it { expect(book).to validate_presence_of(:name) }
 #   it { expect(book).to have_many(:posts) }
 # end
