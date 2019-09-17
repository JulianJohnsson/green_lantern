class ChangeRegimeToBeIntegerInPreferences < ActiveRecord::Migration[5.2]
  def change
    change_column :preferences, :regime, 'integer USING CAST(regime AS integer)'
    change_column :preferences, :energy_contract, 'integer USING CAST(energy_contract AS integer)'
  end
end
