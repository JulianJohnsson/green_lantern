class AddDetailedScoresToScores < ActiveRecord::Migration[5.2]
  def change
    add_column :scores, :week_basic_car, :integer
    add_column :scores, :week_electric_car, :integer
    add_column :scores, :week_moto, :integer
    add_column :scores, :week_public_trans, :integer
    add_column :scores, :energy, :integer
    add_column :scores, :enr, :integer
    add_column :scores, :redmeat, :integer
    add_column :scores, :poultry, :integer
    add_column :scores, :dairy, :integer
    add_column :scores, :goods_furnitures, :decimal
    add_column :scores, :goods_clothes, :decimal
    add_column :scores, :goods_others, :decimal
    add_column :scores, :services_health, :decimal
    add_column :scores, :services_plans, :decimal
    add_column :scores, :services_others, :decimal
  end
end
