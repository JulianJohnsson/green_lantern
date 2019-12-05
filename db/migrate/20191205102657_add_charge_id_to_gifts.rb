class AddChargeIdToGifts < ActiveRecord::Migration[5.2]
  def change
    add_column :gifts, :charge_id, :string
  end
end
