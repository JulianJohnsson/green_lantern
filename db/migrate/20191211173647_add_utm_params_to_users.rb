class AddUtmParamsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :utm_params, :string
  end
end
