class AddAccuracyToTransaction < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :accuracy, :integer
  end
end
