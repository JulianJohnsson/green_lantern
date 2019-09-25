class AddDetailsToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :color, :string
    add_column :categories, :emoji, :string
    add_column :categories, :visible, :boolean
  end
end
