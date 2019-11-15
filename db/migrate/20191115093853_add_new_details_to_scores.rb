class AddNewDetailsToScores < ActiveRecord::Migration[5.2]
  def change
    add_column :scores, :top_category, :text, array: true, default: []
    add_column :scores, :top_transaction, :text, array: true, default: []
    add_column :scores, :top_growth, :text, array: true, default: []
  end
end
