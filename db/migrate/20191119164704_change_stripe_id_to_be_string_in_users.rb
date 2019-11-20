class ChangeStripeIdToBeStringInUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :stripe_id, :string
    change_column :users, :stripe_subscription_id, :string
  end
end
