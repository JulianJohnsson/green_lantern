class AddInfoToScores < ActiveRecord::Migration[5.2]
  def change
    add_column :scores, :long_flights, :integer
    add_column :scores, :short_flights, :integer
    add_column :scores, :house_size, :integer
    add_column :scores, :regime, :integer
  end
end
