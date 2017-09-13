# country
class Country < ApplicationRecord
  has_many :shipping_address
  has_many :billing_address
  has_many :orders
  validates :name, presence: true, uniqueness: true
end
