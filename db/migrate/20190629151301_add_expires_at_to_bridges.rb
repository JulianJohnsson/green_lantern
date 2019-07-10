class AddExpiresAtToBridges < ActiveRecord::Migration[5.2]
  def change
    add_column :bridges, :expires_at, :datetime
  end
end
