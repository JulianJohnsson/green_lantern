class TransactionEnrichment < ApplicationRecord
  belongs_to :category

  scope :auto, -> {where("is_auto = TRUE")}

  def self.enrich_transaction(transaction)
    enrich = TransactionEnrichment.auto.where("description = ?",transaction.description)
    if enrich.present?
      enrich.each do |e|
        m = TransactionModifier.new
        m.transaction_id = transaction.id
        m.modifier_id = e.modifier_id
        m.modifier_option_id = e.modifier_option_id
        m.origin = "auto"
        if m.category_id != nil
          transaction.category_id = m.category_id
        end
        m.save
      end
      transaction.save
    end
  end
end
