module CheckoutStepsHelper
  def menu_header
    Hash[1, 'Address', 2, 'Delivery', 3, 'Payment', 4, 'Confirm', 5, 'Complete']
  end

  def menu_active(index)
    (menu_header.key(params[:id].capitalize) >= index + 1) ? 'active' : ''
  end
end
