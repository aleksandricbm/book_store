# This controller for BookController
class BookController < ApplicationController
  def show
    @book = Book.find(params[:id])
    # binding.pry
    @order_item = current_order.order_items.new
    # binding.pry
  end
end
