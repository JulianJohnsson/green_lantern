class AddCarboneToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :carbone, :decimal
    add_column :transactions, :parent_category_id, :integer
  end
end
