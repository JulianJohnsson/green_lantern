class UpdateTransactionEnrichmentJob < ApplicationJob

  def perform(transaction_modifier)
    existing_enrichment = TransactionEnrichment.where("description = ? AND modifier_option_id = ?", Transaction.find(transaction_modifier.transaction_id).description, transaction_modifier.modifier_option_id).last
    if existing_enrichment.present?
      existing_enrichment.count = (existing_enrichment.count || 0) + 1
      existing_enrichment.save
    else
      enrichment = TransactionEnrichment.new
      enrichment.description = Transaction.find(transaction_modifier.transaction_id).description
      enrichment.category_id = Transaction.find(transaction_modifier.transaction_id).category.id
      enrichment.modifier_id = transaction_modifier.modifier.id
      enrichment.modifier_option_id = transaction_modifier.modifier_option.id
      enrichment.count = 1
      enrichment.save
    end
  end

end
