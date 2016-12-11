class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.string :memo
      t.float :push_val1
      t.float :push_val2
      t.float :pull_val1
      t.float :pull_val2
      t.float :leg_val1
      t.float :leg_val2
      t.float :back_val1
      t.float :back_val2
      t.float :protein_val1
      t.float :protein_val2
      t.float :carbohydrate_val1
      t.float :carbohydrate_val2
      t.float :fat_val1
      t.float :fat_val2
      t.float :vegetable_val1
      t.float :vegetable_val2
      t.float :weight_val1
      t.float :fat_per_val1
      t.float :body_size_neck
      t.float :body_size_bust
      t.float :body_size_waist
      t.float :body_size_hip
      t.float :body_size_arm
      t.float :body_size_leg_right
      t.float :body_size_calf_right

      t.timestamps null: false
    end
  end
end
