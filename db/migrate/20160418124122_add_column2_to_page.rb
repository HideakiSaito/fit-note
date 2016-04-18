class AddColumn2ToPage < ActiveRecord::Migration
  def change
    add_reference :pages, :condition, index: true, foreign_key: true
    add_reference :pages, :feeling, index: true, foreign_key: true
    add_column :pages, :sleep_hour, :float
    add_column :pages, :sleep_time, :time
    add_column :pages, :water, :float
    add_column :pages, :alcohol, :float
    add_column :pages, :caffeine, :float
    add_column :pages, :wight, :float
    add_column :pages, :work_hour, :float
    add_column :pages, :study_hour, :float
    add_column :pages, :tv_hour, :float
  end
end
