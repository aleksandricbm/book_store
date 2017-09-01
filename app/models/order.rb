# This model Order
class Order < ApplicationRecord
  has_many :order_items
  has_many :books, through: :order_items
  belongs_to :coupon, optional: true
  belongs_to :shipping_method, optional: true
  belongs_to :order_status, optional: true

  def total_price
    self.order_items.inject(0) { |sum, item| sum + item.item_total_price }
  end

  def discount
    return self.coupon.price if self.coupon.present?
    0
  end

  def shipping
    return self.shipping_method.price if self.shipping_method.present?
    0
  end

  def order_total
    total_price - discount + shipping
  end

  def total_quantity
    self.order_items.inject(0) { |sum, item| sum + item.quantity }
  end
end
