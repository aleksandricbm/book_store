class CreditCard < ApplicationRecord
  belongs_to :order
  validates :order_id, uniqueness: true
end
