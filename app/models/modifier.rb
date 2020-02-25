class Modifier < ApplicationRecord
  has_and_belongs_to_many :categories
  has_many :modifier_options
  has_many :transaction_modifiers

  enum question_type: [:boolean, :single_choice, :numeric]

end
