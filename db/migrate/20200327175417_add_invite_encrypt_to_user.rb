class AddInviteEncryptToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :invite_encrypt, :string
  end
end
