class CreateFoodVotes < ActiveRecord::Migration
  def change
    create_table :food_votes do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :food, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
