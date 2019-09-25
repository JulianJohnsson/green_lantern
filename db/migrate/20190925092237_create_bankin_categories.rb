class CreateBankinCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :bankin_categories do |t|
      t.integer :bankin_id
      t.integer :category_id

      t.timestamps
    end
  end
end
