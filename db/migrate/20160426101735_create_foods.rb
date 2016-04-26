class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.string :name
      t.belongs_to :diet, index: true, foreign_key: true
      t.float :calorie
      t.float :carbohydrate
      t.float :fat
      t.float :protein
      t.float :vegetable
      t.string :diet_memo

      t.timestamps null: false
    end
  end
end
