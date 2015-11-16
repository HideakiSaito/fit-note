class CreateTrainings < ActiveRecord::Migration
  def change
    create_table :trainings do |t|
      t.belongs_to :item, index: true, foreign_key: true
      t.integer :weight
      t.integer :reps
      t.integer :set
      t.belongs_to :mode, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
