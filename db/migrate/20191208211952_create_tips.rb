class CreateTips < ActiveRecord::Migration[5.2]
  def change
    create_table :tips do |t|
      t.string :title
      t.string :description
      t.string :image
      t.integer :category_id
      t.string :url

      t.timestamps
    end
  end
end
