module CheckoutStepsHelper
  def menu_header
    menu = Hash[1, 'Address', 2, 'Delivery', 3, 'Payment', 4, 'Confirm', 5, 'Complete']
  end

  def menu_active(menu)
    (params[:id] == menu.downcase) ? 'active' : ''
  end
end
