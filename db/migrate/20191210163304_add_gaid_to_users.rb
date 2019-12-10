class AddGaidToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :gaid, :string
  end
end
