class AddCoulumn3ToUser < ActiveRecord::Migration
  def change
    add_column :users, :birthday, :date
  end
end
