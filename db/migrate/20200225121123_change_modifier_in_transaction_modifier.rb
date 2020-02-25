class ChangeModifierInTransactionModifier < ActiveRecord::Migration[5.2]
  def change
    rename_column :transaction_modifiers, :modifier, :coeff
  end
end
