class AddDetailsToGifts < ActiveRecord::Migration[5.2]
  def change
    add_column :gifts, :author_name, :string
    add_column :gifts, :recipient_name, :string
    add_column :gifts, :invitation_text, :text
    add_column :gifts, :formula, :string
  end
end
