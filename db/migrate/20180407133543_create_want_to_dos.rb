class CreateWantToDos < ActiveRecord::Migration
  def change
    create_table :want_to_dos do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.date :estimate
      t.string :title
      t.string :description
      t.string :category
      t.string :status
      t.boolean :done

      t.timestamps null: false
    end
  end
end
