# This controller for CategoryController
class CategoryController < ApplicationController
  # load_and_authorize_resource
  def show
    @category = Category.find(params[:id])
  end
end
