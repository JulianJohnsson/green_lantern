class Category < ApplicationRecord
  has_many :transactions
  scope :parent_categories, -> {where("parent_id=0 AND coeff>0")}
end
