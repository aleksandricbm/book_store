# This model Coupon
class Coupon < ApplicationRecord
  has_many :orders
end
