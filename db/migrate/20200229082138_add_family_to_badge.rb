class AddFamilyToBadge < ActiveRecord::Migration[5.2]
  def change
    add_column :badges, :family, :integer
  end
end
