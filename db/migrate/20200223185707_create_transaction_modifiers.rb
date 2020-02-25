class CreateTransactionModifiers < ActiveRecord::Migration[5.2]
  def change
    create_table :transaction_modifiers do |t|
      t.integer :modifier_option_id
      t.integer :transaction_id
      t.decimal :modifier

      t.timestamps
    end
  end
end
