class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :comment, presence: true, length: { maximum: 500}, format: { with: /\A[A-Za-z0-9]+\z/ }
end
