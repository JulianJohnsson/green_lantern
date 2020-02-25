class TransactionModifier < ApplicationRecord
  #belongs_to :transaction
  belongs_to :modifier_option
  belongs_to :modifier

  before_save :get_modifier

  def get_modifier
    self.coeff =  self.modifier_option.coeff
    Transaction.find(self.transaction_id).save
  end
end
