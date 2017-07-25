# This controller for HomeController
class HomeController < ApplicationController
  # def index; end
  def home
    @latests = Book.includes(:authors).order('id desc').limit(3)
    @bestsellers = Book.includes(:authors).order('reviews_qty desc').limit(4)
  end
end
