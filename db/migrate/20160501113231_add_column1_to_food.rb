class AddColumn1ToFood < ActiveRecord::Migration
  def change
    add_reference :foods, :food_category, index: true, foreign_key: true
  end
end
