class CreatePageSelfies < ActiveRecord::Migration
  def change
    create_table :page_selfies do |t|
      t.belongs_to :page, index: true, foreign_key: true
      t.binary :data
      t.string :content_type

      t.timestamps null: false
    end
  end
end
