class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|
      t.belongs_to :page, index: true, foreign_key: true
      t.integer :no
      t.belongs_to :item, index: true, foreign_key: true
      t.belongs_to :mode, index: true, foreign_key: true
      t.decimal :weight_1
      t.decimal :reps_1
      t.string :memo_1
      t.decimal :weight_2
      t.decimal :reps_2
      t.string :memo_2
      t.decimal :weight_3
      t.decimal :reps_3
      t.string :memo_3
      t.decimal :weight_4
      t.decimal :reps_4
      t.string :memo_4
      t.decimal :weight_5
      t.decimal :reps_5
      t.string :memo_5
      t.decimal :weight_6
      t.decimal :reps_6
      t.string :memo_6
      t.decimal :weight_7
      t.decimal :reps_7
      t.string :memo_7
      t.decimal :weight_8
      t.decimal :reps_8
      t.string :memo_8
      t.decimal :weight_9
      t.decimal :reps_9
      t.string :memo_9
      t.decimal :weight_0
      t.decimal :reps_0
      t.string :memo_0

      t.timestamps null: false
    end
  end
end
