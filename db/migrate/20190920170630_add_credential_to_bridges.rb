class AddCredentialToBridges < ActiveRecord::Migration[5.2]
  def change
    add_column :bridges, :credential, :string
  end
end
