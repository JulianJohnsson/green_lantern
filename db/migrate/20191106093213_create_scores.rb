class CreateScores < ActiveRecord::Migration[5.2]
  def change
    create_table :scores do |t|
      t.integer :country_id
      t.decimal :total
      t.text :detail, array: true, default: []
      t.integer :user_id

      t.timestamps
    end
  end
end
