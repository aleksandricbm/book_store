require "rails_helper"

describe Book, type: :model do
  it { should have_and_belong_to_many :authors }
  it { should belong_to :category }
  it { should have_many :order_items}
  it { should have_many :orders}
  it { should have_many(:orders).through(:order_items)}
  it {
    should validate_presence_of(:name)
    should validate_length_of(:name).is_at_least(2).is_at_most(150)
  }
  it {
    should validate_presence_of(:price)
    should validate_numericality_of(:price)
  }
  it {
    should validate_presence_of(:description)
    should validate_length_of(:description).is_at_least(2).is_at_most(2500)
  }
  it {
    should validate_presence_of(:height)
    should validate_numericality_of(:height).is_greater_than(1)
  }
  it {
    should validate_presence_of(:weight)
    should validate_numericality_of(:weight).is_greater_than(1)
  }
  it {
    should validate_presence_of(:depth)
    should validate_numericality_of(:depth).is_greater_than(1)
  }
  it {
    should validate_presence_of(:material)
    should validate_length_of(:material).is_at_least(2).is_at_most(50)
  }
  it { should validate_presence_of(:category_id) }

end

 # describe Book do
 #   it { expect(book).to validate_presence_of(:email) }
 #   it { expect(book).to validate_uniqueness_of(:email) }
 #   it { expect(book).to validate_presence_of(:name) }
 #   it { expect(book).to have_many(:posts) }
 # end
