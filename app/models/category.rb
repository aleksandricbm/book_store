# This model Category
class Category < ApplicationRecord
  has_many :books

  validates :name, presence: true, uniqueness: true

  scope :filter_status, -> { where("order_statuses.name='Waiting for processing'") }
  scope :distinct_category, -> { select('distinct on(categories.name) categories.name, books.id as book_id, sum(order_items.quantity) as total') }
  scope :join_tables, -> { joins(books: [{ order_items: [{ order: :order_status }] }]) }
end
