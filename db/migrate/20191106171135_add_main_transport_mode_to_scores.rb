class AddMainTransportModeToScores < ActiveRecord::Migration[5.2]
  def change
    add_column :scores, :main_transport_mode, :integer
  end
end
