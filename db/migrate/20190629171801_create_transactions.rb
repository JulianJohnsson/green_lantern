class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.bigint :external_id
      t.string :description
      t.string :raw_description
      t.decimal :amount
      t.date :date
      t.integer :category_id
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
