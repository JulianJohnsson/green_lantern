class AddSubscriptionProjectToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :subscription_project, :string
  end
end
