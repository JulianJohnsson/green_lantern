class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :external_id
      t.decimal :coeff
      t.integer :parent_id

      t.timestamps
    end
  end
end
