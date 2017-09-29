module Sort
  extend ActiveSupport::Concern

  included do
    def sort(sort)
      case sort
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

    def count_book_in_category
      Book.joins(:category).group('categories.name', :category_id).count
    end

    def list_catalog
      @catalog_list = if params[:category].present?
                        Category.find(params[:category]).books
                      else
                        Book.category.order('id asc')
                      end
      @catalog_list = sort(params[:sort]) if params[:sort].present?
      @catalog_list = @catalog_list.page params[:page]
    end
  end
end
