class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :description
      t.string :country
      t.integer :kind
      t.decimal :cost

      t.timestamps
    end
  end
end
