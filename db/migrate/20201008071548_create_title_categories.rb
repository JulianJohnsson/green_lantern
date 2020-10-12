class CreateTitleCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :title_categories do |t|
      t.string :title
      t.integer :category
      t.integer :modifier

      t.timestamps
    end
  end
end
