class CreateGifts < ActiveRecord::Migration[5.2]
  def change
    create_table :gifts do |t|
      t.string :author_email
      t.string :recipient_email
      t.integer :quantity
      t.decimal :price
      t.integer :status

      t.timestamps
    end
  end
end
