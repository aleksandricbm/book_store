# This controller for CatalogController
class CatalogController < ApplicationController
  before_action :list_catalog, only: [:show]
  def show
    binding.pry
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
                      Book.category.where("category_id = #{params[:id]}")
                    else
                      Book.category.order('id asc')
                    end
    @catalog_list = sort if params[:sort].present?
    @catalog_list = @catalog_list.page params[:page]
  end

  def sort
    case params[:sort]
    when 'newest'
      @catalog_list.order('id desc')
    when 'popular'
      @catalog_list.order('id asc')
    when 'price_hi'
      @catalog_list.order('price desc')
    when 'price_low'
      @catalog_list.order('price asc')
    end
  end
end
