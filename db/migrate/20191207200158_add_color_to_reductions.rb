class AddColorToReductions < ActiveRecord::Migration[5.2]
  def change
    add_column :reductions, :color, :string
    add_column :reductions, :hidden, :boolean
  end
end
