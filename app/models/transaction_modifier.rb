class TransactionModifier < ApplicationRecord
  #belongs_to :transaction
  belongs_to :modifier_option
  belongs_to :modifier

  before_save :get_modifier
  after_save :update_transaction_enrichment

  enum origin: [:user, :auto]

  def get_modifier
    self.coeff =  self.modifier_option.coeff
    t = Transaction.find(self.transaction_id)
    t.save
  end

  def update_transaction_enrichment
    if self.origin.present? && self.origin.to_sym == :user
      UpdateTransactionEnrichmentJob.perform_later(self)
    end
  end

end
