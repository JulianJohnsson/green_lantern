class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.integer :user_id
      t.integer :plan
      t.decimal :price
      t.string :frequency
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
