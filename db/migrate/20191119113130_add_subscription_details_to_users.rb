class AddSubscriptionDetailsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :stripe_id, :integer
    add_column :users, :stripe_subscription_id, :integer
    add_column :users, :card_last4, :integer
    add_column :users, :card_exp_month, :integer
    add_column :users, :card_exp_year, :integer
    add_column :users, :card_type, :string
    add_column :users, :subscribed, :boolean
  end
end
