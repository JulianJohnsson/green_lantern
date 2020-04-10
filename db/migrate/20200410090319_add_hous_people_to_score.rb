class AddHousPeopleToScore < ActiveRecord::Migration[5.2]
  def change
    add_column :scores, :house_people, :integer
  end
end
