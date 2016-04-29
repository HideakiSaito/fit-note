class AddCoulumn4ToPage < ActiveRecord::Migration
  def change
    add_column :pages, :body_fat_per, :float
    add_column :pages, :body_size_neck, :float
    add_column :pages, :body_size_bust, :float
    add_column :pages, :body_size_waist, :float
    add_column :pages, :body_size_hip, :float
    add_column :pages, :body_size_arm_right, :float
    add_column :pages, :body_size_arm_left, :float
    add_column :pages, :body_size_leg_right, :float
    add_column :pages, :body_size_leg_left, :float
    add_column :pages, :body_size_calf_right, :float
    add_column :pages, :body_size_calf_left, :float
  end
end
