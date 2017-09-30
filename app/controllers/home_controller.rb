# This controller for HomeController
class HomeController < ApplicationController
  def home
    @latests = Book.author.order_id_desc.limit(3)
    @bestsellers = Category.join_tables.distinct_category.filter_status.group('categories.name', 'books.id').order('name desc, total desc')
  end
end
