class ChangeTypeNameInAccount < ActiveRecord::Migration[5.2]
  def change
    rename_column :accounts, :type, :kind
  end
end
