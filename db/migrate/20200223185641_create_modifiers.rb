class CreateModifiers < ActiveRecord::Migration[5.2]
  def change
    create_table :modifiers do |t|
      t.string :name
      t.integer :question_type
      t.boolean :repeating

      t.timestamps
    end

    create_table :categories_modifiers, id: false do |t|
      t.belongs_to :category
      t.belongs_to :modifier
    end
  end
end
