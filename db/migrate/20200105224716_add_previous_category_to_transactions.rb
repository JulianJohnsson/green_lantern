class AddPreviousCategoryToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :previous_category, :integer
  end
end
