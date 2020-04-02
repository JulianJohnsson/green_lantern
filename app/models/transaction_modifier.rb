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

  def self.deduplicate
    transactions = Transaction.joins(:transaction_modifiers).group('transactions.id').having('count(transaction_id) > 1')
    transactions.each do |transaction|
      transaction_modifiers = transaction.transaction_modifiers.group(:modifier_id).having('count("modifier_id") > 1').count(:modifier_id)
      transaction_modifiers.each do |key,value|
        duplicates = TransactionModifier.where(modifier_id: key)[1..value-1]
        duplicates.each(&:destroy)
      end
    end
  end
end
