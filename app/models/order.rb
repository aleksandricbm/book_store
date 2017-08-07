# This model Order
class Order < ApplicationRecord
  has_many :order_items
  has_many :books, through: :order_items
  belongs_to :coupon, optional: true

  def total_price
    self.order_items.inject(0) { |sum, item| sum + item.item_total_price }
  end

  def discount
    self.coupon.price if self.coupon.present?
    0
  end

  def order_total
    total_price - discount
  end

  def total_quantity
    self.order_items.inject(0) { |sum, item| sum + item.quantity }
  end
end
