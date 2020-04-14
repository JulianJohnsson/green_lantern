class AddStatusInfoToAccount < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :status_info, :string
  end
end
