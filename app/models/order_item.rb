# This model OrderItem
class OrderItem < ApplicationRecord
  belongs_to :book
  belongs_to :order

  def add_book(current_item)
    current_item.quantity += 1 if current_item.quantity?
  end

  def remove_book(current_item)
    if current_item.quantity > 1
      current_item.quantity -= 1
    elsif current_item.quantity == 1
      current_item.destroy
    end
    current_item
  end

  def item_total_price
    self.price * self.quantity
  end
end
