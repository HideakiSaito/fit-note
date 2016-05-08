class DelColumn1ToPage < ActiveRecord::Migration
  def change
    remove_column :pages, :image
  end
end
