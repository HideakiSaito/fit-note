class CreateConditions < ActiveRecord::Migration
  def change
    create_table :conditions do |t|
      t.string :name
      t.float :score
      t.string :memo

      t.timestamps null: false
    end
  end
end
