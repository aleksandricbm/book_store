class CreateOrderItems < ActiveRecord::Migration[5.1]
  def change
    create_table :order_items do |t|
      t.belongs_to :book, foreign_key: true
      t.belongs_to :order, foreign_key: true
      t.integer :quantity
      t.decimal :price, precision: 8, scale: 2
      t.string :status

      t.timestamps
    end
  end
end
