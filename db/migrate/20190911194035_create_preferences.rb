class CreatePreferences < ActiveRecord::Migration[5.2]
  def change
    create_table :preferences do |t|
      t.integer :user_id
      t.string :city
      t.string :regime
      t.string :energy_contract

      t.timestamps
    end
  end
end
