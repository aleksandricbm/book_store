# This model Order
class Order < ApplicationRecord
  has_many :order_items
  has_many :books, through: :order_items

  def total_price
    self.order_items.inject(0) { |sum, item| sum + item.item_total_price }
  end

  def discount
    0
  end

  def order_total
    total_price - discount
  end

  def total_quantity
    self.order_items.inject(0) { |sum, item| sum + item.quantity }
  end
end
