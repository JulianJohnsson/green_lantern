class AddSuggestedCategoryIdToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :suggested_category_id, :integer
  end
end
