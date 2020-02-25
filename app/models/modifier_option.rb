class ModifierOption < ApplicationRecord
  has_many :transactions
  belongs_to :modifier

end
