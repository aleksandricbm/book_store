# This helpers for ApplicationHelper
module ApplicationHelper
  def shop_quantity
    "<span class='shop-quantity'>#{current_order.total_quantity}</span>".html_safe unless current_order.order_items.count < 1
  end

  def active_category (category)
    (params[:id].to_i == category.to_i) ? 'active' : ''
  end
end
