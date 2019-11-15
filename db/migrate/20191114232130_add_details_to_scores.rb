class AddDetailsToScores < ActiveRecord::Migration[5.2]
  def change
    add_column :scores, :recent_total, :decimal
    add_column :scores, :recent_detail, :text, array: true, default: []
  end
end
