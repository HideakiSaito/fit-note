class CreateTipRecommendations < ActiveRecord::Migration
  def change
    create_table :tip_recommendations do |t|
      t.string :name
      t.integer :rate

      t.timestamps null: false
    end
  end
end
