class CreateTips < ActiveRecord::Migration
  def change
    create_table :tips do |t|
      t.belongs_to :tip_category, index: true, foreign_key: true
      t.belongs_to :tip_recommendation, index: true, foreign_key: true
      t.string :name
      t.string :description
      t.string :author

      t.timestamps null: false
    end
  end
end
