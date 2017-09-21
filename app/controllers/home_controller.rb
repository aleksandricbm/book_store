# This controller for HomeController
class HomeController < ApplicationController
  def home
    @latests = Book.author.order_id_desc.limit(3)
    @bestsellers = Category.joins(books: [{ order_items: [{ order: :order_status }] }]).select('distinct on(categories.name) categories.name, books.id as book_id, sum(order_items.quantity) as total').where("order_statuses.name='Waiting for processing'").group('categories.name', 'books.id').order('name desc, total desc')
  end
end
