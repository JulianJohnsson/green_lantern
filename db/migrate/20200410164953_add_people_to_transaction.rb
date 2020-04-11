class AddPeopleToTransaction < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :people, :integer, :default => 1
  end
end
