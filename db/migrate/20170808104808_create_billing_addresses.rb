class CreateBillingAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :billing_addresses do |t|
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :city
      t.string :zip
      t.string :phone
      t.belongs_to :user, foreign_key: true
      t.belongs_to :country, foreign_key: true

      t.timestamps
    end
  end
end
