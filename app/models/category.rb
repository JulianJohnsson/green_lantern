class Category < ApplicationRecord
  scope :parent_categories, -> {where("parent_id=0 AND coeff>0")}
end
