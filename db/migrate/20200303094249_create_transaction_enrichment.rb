class CreateTransactionEnrichment < ActiveRecord::Migration[5.2]
  def change
    create_table :transaction_enrichments do |t|
      t.string :description
      t.integer :category_id
      t.integer :modifier_id
      t.integer :modifier_option_id
      t.integer :count
      t.boolean :is_auto
    end
  end
end
