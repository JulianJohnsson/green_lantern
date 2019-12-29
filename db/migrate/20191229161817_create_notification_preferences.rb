class CreateNotificationPreferences < ActiveRecord::Migration[5.2]
  def change
    create_table :notification_preferences do |t|
      t.integer :user_id
      t.boolean :weekly_score_update, :default => true

      t.timestamps
    end
  end
end
