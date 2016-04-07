class AddColumnToPage < ActiveRecord::Migration
  def change
    add_reference :pages, :diet, index: true, foreign_key: true
    add_column :pages, :carbohydrate_1, :float
    add_column :pages, :fat_1, :float
    add_column :pages, :protein_1, :float
    add_column :pages, :vegetable_1, :float
    add_column :pages, :diet_memo_1, :string
    add_column :pages, :carbohydrate_2, :float
    add_column :pages, :fat_2, :float
    add_column :pages, :protein_2, :float
    add_column :pages, :vegetable_2, :float
    add_column :pages, :diet_memo_2, :string
    add_column :pages, :carbohydrate_3, :float
    add_column :pages, :fat_3, :float
    add_column :pages, :protein_3, :float
    add_column :pages, :vegetable_3, :float
    add_column :pages, :diet_memo_3, :string
    add_column :pages, :carbohydrate_4, :float
    add_column :pages, :fat_4, :float
    add_column :pages, :protein_4, :float
    add_column :pages, :vegetable_4, :float
    add_column :pages, :diet_memo_4, :string
    add_column :pages, :carbohydrate_5, :float
    add_column :pages, :fat_5, :float
    add_column :pages, :protein_5, :float
    add_column :pages, :vegetable_5, :float
    add_column :pages, :diet_memo_5, :string
  end
end
