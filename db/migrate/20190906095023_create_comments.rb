class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :transaction_id
      t.string :description
      t.string :author

      t.timestamps
    end
  end
end
