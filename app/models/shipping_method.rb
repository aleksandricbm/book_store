# This model ShippingMethod
class ShippingMethod < ApplicationRecord
  has_many :orders

  validates :name, presence: true, length: {minimum: 2}
  validates :duration, presence: true, length: {minimum: 2}
  validates :price, presence: true, numericality: { only_float: true, greater_than: 1 }
end
