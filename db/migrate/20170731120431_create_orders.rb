class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :order
      t.string :status
      t.bigint :user_id
      t.decimal :total_price, precision: 8, scale: 2

      t.timestamps
    end
  end
end
