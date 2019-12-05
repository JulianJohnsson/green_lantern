class AddCountryIdToGifts < ActiveRecord::Migration[5.2]
  def change
    add_column :gifts, :country_id, :integer
  end
end
