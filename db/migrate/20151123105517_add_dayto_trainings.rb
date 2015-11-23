class AddDaytoTrainings < ActiveRecord::Migration
  def change
    add_column :trainings , :day , :date
    add_column :trainings , :num , :integer
  end
end
