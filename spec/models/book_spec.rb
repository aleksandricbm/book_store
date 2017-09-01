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

  it { should have_many :reviews}

  it "applies a default scope to collections" do
    expect(Book.author.to_sql).to eq Book.all.includes(:authors).to_sql
    expect(Book.category.to_sql).to eq Book.all.includes(:category).to_sql
    expect(Book.order_id_desc.to_sql).to eq Book.all.order('id desc').to_sql
    expect(Book.order_review_desc.to_sql).to eq Book.all.order('reviews_qty desc').to_sql
    expect(Book.author.order_id_desc.to_sql).to eq Book.all.includes(:authors).order('id desc').to_sql
    expect(Book.author.order_review_desc.to_sql).to eq Book.all.includes(:authors).order('reviews_qty desc').to_sql
  end

end
