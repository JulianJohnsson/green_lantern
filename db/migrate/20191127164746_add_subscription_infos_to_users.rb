class AddSubscriptionInfosToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :subscription_plan, :string
    add_column :users, :subscription_price, :decimal
    add_column :users, :subscription_started_at, :date
  end
end
