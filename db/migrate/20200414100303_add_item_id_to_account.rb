class AddItemIdToAccount < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :item_id, :integer
  end
end
