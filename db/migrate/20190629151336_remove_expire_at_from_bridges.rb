class RemoveExpireAtFromBridges < ActiveRecord::Migration[5.2]
  def change
    remove_column :bridges, :expire_at, :date
  end
end
