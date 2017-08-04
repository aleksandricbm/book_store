# This helpers for ApplicationHelper
module ApplicationHelper
  def shop_quantity
    templ = "<span class='shop-quantity'>#{current_order.total_quantity}</span>"
    templ.html_safe unless current_order.total_quantity < 1
  end
end
