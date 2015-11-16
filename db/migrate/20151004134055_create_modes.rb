class CreateModes < ActiveRecord::Migration
  def change
    create_table :modes do |t|
      t.string :name
      t.string :detail

      t.timestamps null: false
    end
  end
end
