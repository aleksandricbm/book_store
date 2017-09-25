# This helpers for ApplicationHelper
module ApplicationHelper
  def shop_quantity
    "<span class='shop-quantity'>#{current_order.total_quantity}</span>".html_safe if current_order.order_items.count > 0
  end

  def active_category (category)
    (params[:id].to_i == category.to_i) ? 'active' : ''
  end
end
