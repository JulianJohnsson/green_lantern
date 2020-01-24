class CreateUserModifiers < ActiveRecord::Migration[5.2]
  def change
    create_table :user_modifiers do |t|
      t.integer :category_id
      t.integer :user_id
      t.decimal :carbone_modifier

      t.timestamps
    end
  end
end
