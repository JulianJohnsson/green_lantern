class AddUpdatedByUserToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :updated_by_user, :boolean
  end
end
