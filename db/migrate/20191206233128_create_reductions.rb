class CreateReductions < ActiveRecord::Migration[5.2]
  def change
    create_table :reductions do |t|
      t.integer :user_id
      t.integer :category_id
      t.integer :parent_category_id
      t.string :title
      t.decimal :month_carbone
      t.decimal :month_cost
      t.string :image

      t.timestamps
    end
  end
end
