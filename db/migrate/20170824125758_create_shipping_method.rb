class CreateShippingMethod < ActiveRecord::Migration[5.1]
  def change
    create_table :shipping_methods do |t|
      t.string   :name
      t.string   :duration
      t.decimal  :price, precision: 8, scale: 2
    end
    add_reference :shipping_methods, :order, foreign_key: true
  end
end
