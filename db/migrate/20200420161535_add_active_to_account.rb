class AddActiveToAccount < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :active, :boolean, :default => true
  end
end
