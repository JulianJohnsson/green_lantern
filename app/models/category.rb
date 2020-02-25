class Category < ApplicationRecord
  has_many :transactions
  belongs_to :parent, :class_name => 'Category', optional: true
  has_many :children, -> { order(:name) }, :class_name => 'Category', :foreign_key => 'parent_id'
  has_and_belongs_to_many :modifiers

  after_update :update_transactions, if: :saved_change_to_coeff?

  scope :root_categories, -> {where("id IN (1,12,24,25,70,136)")}
  scope :parent_categories, -> {where("parent_id=0 AND coeff>0")}
  scope :sub_categories, -> (int) {where("parent_id = ?", int)}

  def update_transactions
    transactions = Transaction.all.category_id(self.id)
    transactions.each do |t|
      t.save
    end
  end

end
