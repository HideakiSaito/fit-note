class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.date :date
      t.string :place
      t.time :start_time
      t.time :end_time
      t.text :memo
      t.binary :image

      t.timestamps null: false
    end
  end
end
