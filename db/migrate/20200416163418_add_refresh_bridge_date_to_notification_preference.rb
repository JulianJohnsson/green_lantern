class AddRefreshBridgeDateToNotificationPreference < ActiveRecord::Migration[5.2]
  def change
    add_column :notification_preferences, :refresh_bridge_date, :datetime
  end
end
