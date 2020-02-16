class ChangeCarboneMinToDecimalInEquivalents < ActiveRecord::Migration[5.2]
  def change
    change_column :equivalents, :carbone_min, :decimal
  end
end
