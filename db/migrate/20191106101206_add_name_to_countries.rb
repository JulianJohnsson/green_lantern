class AddNameToCountries < ActiveRecord::Migration[5.2]
  def change
    add_column :countries, :name, :string
  end
end
