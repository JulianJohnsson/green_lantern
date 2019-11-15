class AddInfoToCountries < ActiveRecord::Migration[5.2]
  def change
    add_column :countries, :house_size, :integer
    add_column :countries, :furniture, :decimal
    add_column :countries, :clothes, :decimal
    add_column :countries, :other_goods, :decimal
    add_column :countries, :healthcare, :decimal
    add_column :countries, :subscriptions, :decimal
    add_column :countries, :other_services, :decimal
  end
end
