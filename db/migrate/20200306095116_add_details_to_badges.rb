class AddDetailsToBadges < ActiveRecord::Migration[5.2]
  def change
    add_column :badges, :url, :string
    add_column :badges, :active, :boolean
  end
end
