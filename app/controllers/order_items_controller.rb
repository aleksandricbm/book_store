# This controller Order_Items
class OrderItemsController < ApplicationController
  before_action :find_order, only: %i[create destroy decrease increase]
  before_action :find_item, only: %i[destroy decrease increase]
  after_action :order_save, only: %i[destroy create]

  def create
    @item = @order.order_items.new(item_params)
    @item.price = Book.find(item_params[:book_id]).price
    session[:order_id] = @order.id
    respond_to do |format|
      format.html
      format.js { render layout: false, locals: { qty: @order.total_quantity }, file: 'carts/_head_quantity_cart' }
    end
  end

  def destroy
    @item.destroy
    redirect_to cart_path
  end

  def decrease
    @item.remove_book(@item)
    @item.save
    redirect_to cart_path
  end

  def increase
    @item.add_book(@item)
    @item.save
    redirect_to cart_path
  end

  private

  def find_item
    @item = @order.order_items.find(params[:id])
  end

  def order_save
    @order.save
  end

  def find_order
    @order = current_order
  end

  def item_params
    params.require(:order_item).permit(:quantity, :book_id)
  end
end
