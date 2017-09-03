class CreditCard < ApplicationRecord
  belongs_to :order
  validates :order_id, uniqueness: true
  validates :number, numericality: { only_integer: true }, format: { with: /\A[0-9]+\z/ }
  validates :name, presence: true, length: { maximum: 50}, format: { with: /\A[A-Za-z]+\z/ }
  validates :expired, presence: true, length: { is: 4}, format: { with: /A(1[0-2]|0[1-9]|\d)(\d{2})\z/}
  validates :cvv, numericality: { only_integer: true }, format: { with: /A[0-9]{3,4}\z/ }
end
