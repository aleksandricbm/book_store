# This model Coupon
class Coupon < ApplicationRecord
  has_many :orders

  validates :code, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { only_float: true, greater_than: 1 }
end
