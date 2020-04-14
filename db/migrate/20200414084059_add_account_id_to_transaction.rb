class AddAccountIdToTransaction < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :account_id, :integer
  end
end
