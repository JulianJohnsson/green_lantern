class AddUuidToBridges < ActiveRecord::Migration[5.2]
  def change
    add_column :bridges, :uuid, :string
  end
end
