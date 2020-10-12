class CreateShineCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :shine_categories do |t|
      t.string :key
      t.integer :category_id

      t.timestamps
    end
  end
end
