class AddOnboardedToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :onboarded, :boolean
  end
end
