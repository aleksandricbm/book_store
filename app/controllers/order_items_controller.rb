# This controller Order_Items
class OrderItemsController < ApplicationController
  before_action :find_order, only: %i[create destroy decrease increase]
  before_action :find_item, only: %i[destroy decrease increase]

  def create
    binding.pry
    if @order.order_items.find_by(book_id: item_params[:book_id])
      @item = @order.order_items.find_by(book_id: item_params[:book_id])
      increase
    else
      @item = @order.order_items.new(item_params)
      @item.price = Book.find(item_params[:book_id]).price
      @order.save
      session[:order_id] = @order.id
      respond_to do |format|
        format.html
        format.js { render layout: false, locals: { qty: @order.total_quantity }, file: 'carts/_head_quantity_cart' }
      end
    end
  end

  def destroy
    @item.destroy
    @order.save
    redirect_cart
  end

  def decrease
    @item.remove_book(@item)
    @item.save
    redirect_cart
  end

  def increase
    @item.add_book(@item)
    @item.save
    respond_to do |format|
      format.html { redirect_to cart_path }
      format.js { render layout: false, locals: { qty: @order.total_quantity }, file: 'carts/_head_quantity_cart' }
    end
  end

  private

  def find_item
    @item = @order.order_items.find(params[:id])
  end

  def redirect_cart
    redirect_to cart_path
  end

  def find_order
    @order = current_order
  end

  def item_params
    params.require(:order_item).permit(:quantity, :book_id)
  end
end
