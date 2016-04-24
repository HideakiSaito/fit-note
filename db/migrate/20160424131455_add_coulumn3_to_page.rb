class AddCoulumn3ToPage < ActiveRecord::Migration
  def change
    add_column :pages, :training_hour, :float
  end
end
