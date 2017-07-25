require 'ffaker'

def generate_data
  @authors, @books = [], []
  @categories_type = ['Photo', 'Mobile development', 'Web design', 'Web development']

  @categories_type.map { |categ| Category.create(name: categ)}

  25.times { Author.create(name: FFaker::Book.author) }
  160.times do
    Book.create!(
        name:         FFaker::Book.title,
        price:        rand(1.0..999.0),
        description:  FFaker::Book.description,
        public_y:     FFaker::IdentificationESCO.expedition_date,
        height:       rand(1...100),
        weight:       rand(1...100),
        depth:        rand(1...100),
        material:     FFaker::Book.genre,
        reviews_qty:  rand(1...100),
        category_id:  Category.find(rand(1...5)).id
        )
  end

    Book.all.map do |book|
      Author.find(rand(1..25)).books << book
    end

end

generate_data
