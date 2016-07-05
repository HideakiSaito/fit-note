class AddColumnUserToPage < ActiveRecord::Migration
  def change
    add_reference :pages, :user, index: true, foreign_key: true
  end
end
