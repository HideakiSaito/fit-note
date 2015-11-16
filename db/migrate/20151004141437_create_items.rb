class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.integer :reps
      t.belongs_to :part, index: true, foreign_key: true
      t.belongs_to :mode, index: true, foreign_key: true
      t.belongs_to :equipment, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
