class CreateOrderStatus < ActiveRecord::Migration[5.1]
  def change
    create_table :order_statuses do |t|
      t.string :name
    end
    add_reference :orders, :order_status, foreign_key: true
  end
end
