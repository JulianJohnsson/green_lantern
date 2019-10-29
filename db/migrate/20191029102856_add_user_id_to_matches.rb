class AddUserIdToMatches < ActiveRecord::Migration[5.2]
  def change
    add_column :matches, :user_id, :integer
    add_column :matches, :opponent_id, :integer
    add_column :matches, :badge, :string
  end
end
