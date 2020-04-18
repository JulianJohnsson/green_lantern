class TransactionEnrichmentJob < ApplicationJob

  def perform(transaction)
    TransactionEnrichment.enrich_transaction(transaction)
  end

end
