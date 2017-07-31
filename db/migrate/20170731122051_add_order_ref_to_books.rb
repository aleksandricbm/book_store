class AddOrderRefToBooks < ActiveRecord::Migration[5.1]
  def change
    add_reference :books, :order, foreign_key: true
  end
end
