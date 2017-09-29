class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :comment, presence: true, length: { maximum: 500 }, format: { with: /\A[A-Za-z0-9]+\z/ }

  scope :unprocessed, -> { where(check: 0) }
  scope :processed, -> { where(check: 1) }
end
