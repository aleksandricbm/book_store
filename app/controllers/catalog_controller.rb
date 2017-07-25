# This controller for CatalogController
class CatalogController < ApplicationController
  def show
    @catalog = if params[:id].present?
                 Book.includes(:category).find_by category_id: params[:id]
               else
                 Book.includes(:category).order('id asc').limit(12)
               end
    @count_book_in_category = count_book_in_category
  end

  private

  def count_book_in_category
    Book.joins(:category).group('categories.name', :category_id).count
  end
end
