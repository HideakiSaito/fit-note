class CreateItemVotes < ActiveRecord::Migration
  def change
    create_table :item_votes do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :item, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
