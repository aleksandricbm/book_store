# This Book
class Book < ApplicationRecord
  has_and_belongs_to_many :authors
  belongs_to :category
  has_many :order_items
  has_many :orders, through: :order_items
  has_many :reviews
  has_many :images, dependent: :destroy

  validates :name, presence: true, length: { minimum: 2, maximum: 150 }
  validates :price, presence: true, numericality: { greater_than: 1 }
  validates :description, presence: true, length: { minimum: 2, maximum: 2500 }
  validates :height, presence: true, numericality: { only_float: true, greater_than: 1 }
  validates :weight, presence: true, numericality: { only_float: true, greater_than: 1 }
  validates :depth, presence: true, numericality: { only_float: true, greater_than: 1 }
  validates :material, presence: true, length: { minimum: 2, maximum: 50 }
  validates :category_id, presence: true

  scope :author, -> { includes(:authors) }
  scope :category, -> { includes(:category) }
  scope :order_id_desc, -> { order('id desc') }
end
