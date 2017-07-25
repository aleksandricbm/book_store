require 'ffaker'

def generate_data
  @authors, @books = [], []
  @categories_type = ['Photo', 'Mobile development', 'Web design', 'Web development']

  @categories_type.map { |categ| Category.create(name: categ)}

  5.times { Author.create(name: FFaker::Book.author) }
  15.times do
    Book.create!(
        name:         FFaker::Book.title,
        price:        rand(1.0..9990.0),
        description:  FFaker::Book.description,
        public_y:     FFaker::IdentificationESCO.expedition_date,
        height:       rand(1...1000),
        weight:       rand(1...1000),
        depth:        rand(1...1000),
        material:     FFaker::Book.genre,
        reviews_qty:  rand(1...100),
        category_id:  Category.find(rand(1...5)).id
        )
  end

    Book.all.map do |book|
      Author.find(rand(1..5)).books << book
    end

end

generate_data
