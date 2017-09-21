class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.string  :file
      t.references :book, foreign_key: true

      t.timestamps
    end
  end
end
