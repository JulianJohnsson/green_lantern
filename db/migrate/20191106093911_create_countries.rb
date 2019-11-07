class CreateCountries < ActiveRecord::Migration[5.2]
  def change
    create_table :countries do |t|
      t.decimal :total
      t.text :detail, array: true, default: []

      t.timestamps
    end
  end
end
