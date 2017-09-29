class BooksController < ApplicationController
  load_and_authorize_resource

  include Sort

  before_action :list_catalog, only: [:index]
  def index
    @category ||= if param_category
                    Category.find_by(id: param_category[:category])
                  else
                    Category.all
                  end
    @count_book_in_category = count_book_in_category
    respond_to do |format|
      format.html
      format.js { render layout: false, location: catalog_path(@catalog_list) }
    end
  end

  def show
    @book = Book.find(params[:id])
    @order_item = current_order.order_items.new
  end

  private

  def param_category
    params.permit(:category)
  end
end
