class AddModifierIdToTransactionModifier < ActiveRecord::Migration[5.2]
  def change
    add_column :transaction_modifiers, :modifier_id, :integer
  end
end
