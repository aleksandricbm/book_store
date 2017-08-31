# This controller for HomeController
class HomeController < ApplicationController

  def home
    @latests = Book.author.order_id_desc.limit(3)
    @bestsellers = Book.author.order_review_desc.limit(4)
  end
end
