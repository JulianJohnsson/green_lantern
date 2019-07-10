class CreateBridges < ActiveRecord::Migration[5.2]
  def change
    create_table :bridges do |t|
      t.string :token
      t.date :expire_at
      t.boolean :bank_connected
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
