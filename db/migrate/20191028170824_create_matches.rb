class CreateMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :matches do |t|
      t.string :name
      t.string :image
      t.text :data, array: true, default: []

      t.timestamps
    end
  end
end
