class CreateNotificationData < ActiveRecord::Migration[5.2]
  def change
    create_table :notification_data do |t|
      t.string :endpoint
      t.string :p256dh_key
      t.string :auth_key
      t.integer :user_id

      t.timestamps
    end
  end
end
