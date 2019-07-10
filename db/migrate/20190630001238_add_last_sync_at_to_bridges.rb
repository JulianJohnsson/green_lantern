class AddLastSyncAtToBridges < ActiveRecord::Migration[5.2]
  def change
    add_column :bridges, :last_sync_at, :datetime
  end
end
