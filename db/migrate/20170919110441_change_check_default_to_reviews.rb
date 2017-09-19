class ChangeCheckDefaultToReviews < ActiveRecord::Migration[5.1]
  def change
    change_column :reviews, :check, :integer, default: 0
  end
end
