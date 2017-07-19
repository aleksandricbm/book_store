class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      ## Database book
      t.string    :name,        null: false
      t.decimal   :price,       precision: 8, scale: 2
      t.text      :description
      t.date      :public_y
      t.integer   :height,      limit: 2
      t.integer   :weight,      limit: 2
      t.integer   :depth,       limit: 2
      t.string    :material
      t.integer   :reviews_qty

      t.timestamps
    end
  end
end
