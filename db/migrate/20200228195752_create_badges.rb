class CreateBadges < ActiveRecord::Migration[5.2]
  def change
    create_table :badges do |t|
      t.string :name
      t.text :short_desc
      t.string :image

      t.timestamps
    end
  end
end
