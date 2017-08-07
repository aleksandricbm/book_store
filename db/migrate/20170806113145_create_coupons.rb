class CreateCoupons < ActiveRecord::Migration[5.1]
  def change
    create_table :coupons do |t|
      t.string :code
      t.decimal :price, precision: 8, scale: 2
    end
  end
end
