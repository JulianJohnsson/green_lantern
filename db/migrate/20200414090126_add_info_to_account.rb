class AddInfoToAccount < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :type, :string
    add_column :accounts, :last_sync_at, :datetime
  end
end
