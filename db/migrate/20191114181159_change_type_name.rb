class ChangeTypeName < ActiveRecord::Migration[5.2]
  def change
    rename_column :scores, :type, :kind
  end
end
