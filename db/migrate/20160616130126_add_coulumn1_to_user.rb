class AddCoulumn1ToUser < ActiveRecord::Migration
  def change
    add_column :users, :hashed_password, :string
  end
end
