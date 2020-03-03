class AddOriginToTransactionModifier < ActiveRecord::Migration[5.2]
  def change
    add_column :transaction_modifiers, :origin, :integer
  end
end
