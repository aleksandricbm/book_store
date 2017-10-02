require "rails_helper"

describe Book, type: :model do
  it { is_expected.to have_and_belong_to_many :authors }
  it { is_expected.to belong_to :category }
  it { is_expected.to have_many :order_items}
  it { is_expected.to have_many :orders}
  it { is_expected.to have_many(:orders).through(:order_items)}
  it "Book name" do
    is_expected.to validate_presence_of(:name)
    is_expected.to validate_length_of(:name).is_at_least(2).is_at_most(150)
  end

  it "Book price" do
    is_expected.to validate_presence_of(:price)
    is_expected.to validate_numericality_of(:price)
  end

  it "Book description" do
    is_expected.to validate_presence_of(:description)
    is_expected.to validate_length_of(:description).is_at_least(2).is_at_most(2500)
  end

  it "Book height" do
    is_expected.to validate_presence_of(:height)
    is_expected.to validate_numericality_of(:height).is_greater_than(1)
  end

  it "Book weight" do
    is_expected.to validate_presence_of(:weight)
    is_expected.to validate_numericality_of(:weight).is_greater_than(1)
  end

  it "Book depth" do
    is_expected.to validate_presence_of(:depth)
    is_expected.to validate_numericality_of(:depth).is_greater_than(1)
  end

  it "Book material" do
    is_expected.to validate_presence_of(:material)
    is_expected.to validate_length_of(:material).is_at_least(2).is_at_most(50)
  end

  it { is_expected.to validate_presence_of(:category_id) }

  it { is_expected.to have_many :reviews}

  it "applies a default scope to collections" do
    expect(Book.author.to_sql).to eq Book.all.includes(:authors).to_sql
    expect(Book.category.to_sql).to eq Book.all.includes(:category).to_sql
    expect(Book.order_id_desc.to_sql).to eq Book.all.order('id desc').to_sql
    expect(Book.author.order_id_desc.to_sql).to eq Book.all.includes(:authors).order('id desc').to_sql
  end

end
