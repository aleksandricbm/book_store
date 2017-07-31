# This Book
class Book < ApplicationRecord
  has_and_belongs_to_many :authors
  belongs_to :category
  has_many :order_items
  has_many :orders, through: :order_items
end
