class AddContextToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :context, :string
  end
end
