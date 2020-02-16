class CreateEquivalents < ActiveRecord::Migration[5.2]
  def change
    create_table :equivalents do |t|
      t.string :name
      t.integer :carbone_min
      t.integer :carbone_max
      t.string :emoji
      t.integer :kind

      t.timestamps
    end
  end
end
