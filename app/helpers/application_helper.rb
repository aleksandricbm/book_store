# This helpers for ApplicationHelper
module ApplicationHelper
  def shop_quantity
    templ = "<span class='shop-quantity'>#{current_order.total_quantity}</span>"
    templ.html_safe unless current_order.total_quantity < 1
  end

  def active_category (category)
    p "#{params[:id]} = #{category}"
    (params[:id].to_i == category.to_i) ? 'active' : ''
  end
end
