class CreateModifierOptions < ActiveRecord::Migration[5.2]
  def change
    create_table :modifier_options do |t|
      t.integer :modifier_id
      t.string :name
      t.decimal :modifier
      t.boolean :is_numeric
      t.decimal :min
      t.decimal :max
      t.decimal :coeff

      t.timestamps
    end
  end
end
