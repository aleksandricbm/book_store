# This model ShippingAdress
class ShippingAddress < ApplicationRecord
  belongs_to :user
  belongs_to :order
  belongs_to :country, optional: true
  validates :first_name, presence: true, length: { minimum: 2 }
  validates :last_name, presence: true, length: { minimum: 2 }
  validates :address, presence: true, length: { minimum: 5 }
  validates :city, presence: true, length: { minimum: 3 }
  validates :zip, numericality: { only_integer: true }
  validates :phone, numericality: true
end
