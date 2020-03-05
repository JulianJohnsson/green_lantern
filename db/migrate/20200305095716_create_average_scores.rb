class CreateAverageScores < ActiveRecord::Migration[5.2]
  def change
    create_table :average_scores do |t|
      t.decimal :year_total
      t.text :year_detail, array: true, default: []
      t.decimal :month_total
      t.text :month_detail, array: true, default: []
      t.decimal :week_total
      t.text :week_detail, array: true, default: []
      t.integer :score_kind

      t.timestamps
    end
  end
end
