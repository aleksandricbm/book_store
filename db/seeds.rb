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
        height:       rand(2...100),
        weight:       rand(2...100),
        depth:        rand(2...100),
        material:     FFaker::Book.genre,
        reviews_qty:  rand(1...100),
        category_id:  Category.find(rand(1...5)).id
        )
  end

  Book.all.map do |book|
    Author.find(rand(1..25)).books << book
  end

  25.times { Country.create(name: FFaker::Address.country) }

  Coupon.create(code: '10', price: 10)

  ShippingMethod.create(name: 'Delivery Next Day!', duration: '1 to 2 days', price: 28.5)
  ShippingMethod.create(name: 'Standard Delivery', duration: '2 to 4 days', price: 18.5)

  OrderStatus.create(name: 'Waiting for processing')
  OrderStatus.create(name: 'In Progress')
  OrderStatus.create(name: 'In delivery')
  OrderStatus.create(name: 'Delivered')
  OrderStatus.create(name: 'Canceled')

  User.create(email: 'admin@admin.com', password: 'adminadmin', password_confirmation: 'adminadmin', role: 'admin')
end

generate_data
