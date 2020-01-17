class AddUpdatedBySimilarToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :updated_by_similar, :boolean
  end
end
