# This controller for BookController
class BookController < ApplicationController
  def show
    @book = Book.find(params[:id])
    @order_item = current_order.order_items.new
  end
end
