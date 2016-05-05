class AddColumn2ToFood < ActiveRecord::Migration
  def change
    add_column :foods, :sort_key, :string
  end
end
