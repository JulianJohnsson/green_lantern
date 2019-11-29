class AddDetailsToProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :image, :string
    add_column :projects, :why, :text
  end
end
