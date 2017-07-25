# This controller for CatalogController
class CatalogController < ApplicationController
  def show
    list_catalog
    @count_book_in_category = count_book_in_category

    respond_to do |format|
      format.html
      format.js { render layout: false, location: catalog_path(@catalog_list) }
    end
  end

  private

  def count_book_in_category
    Book.joins(:category).group('categories.name', :category_id).count
  end

  def list_catalog
    @catalog_list = if params[:id].present?
                      Book.includes(:category).where("category_id = #{params[:id]}")
                    else
                      Book.includes(:category).order('id asc')
                    end
    @catalog_list = @catalog_list.page params[:page]
  end
end
