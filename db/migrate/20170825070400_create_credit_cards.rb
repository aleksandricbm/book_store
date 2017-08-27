class CreateCreditCards < ActiveRecord::Migration[5.1]
  def change
    create_table :credit_cards do |t|
      t.bigint :number
      t.string :name
      t.string :expired
      t.integer :cvv

      t.timestamps

      t.references :order, foreign_key: true, unique: true
    end
  end
end
