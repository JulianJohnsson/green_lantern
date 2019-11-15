class AddTypeToScores < ActiveRecord::Migration[5.2]
  def change
    add_column :scores, :type, :integer
  end
end
