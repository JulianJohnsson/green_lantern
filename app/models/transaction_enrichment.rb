class TransactionEnrichment < ApplicationRecord
  belongs_to :category

  after_save :enrich_past_transactions, if: :saved_change_to_is_auto?

  scope :auto, -> {where("is_auto = TRUE")}

  def self.enrich_transaction(transaction)
    enrich = TransactionEnrichment.auto.where("description = ?",transaction.description)
    if enrich.present?
      enrich.each do |e|
        if e.modifier_id.present?
          m = TransactionModifier.new
          m.transaction_id = transaction.id
          m.modifier_id = e.modifier_id
          m.modifier_option_id = e.modifier_option_id
          m.origin = "auto"
          transaction.category_id = e.category_id if e.category_id.present?
          m.save
        else
          transaction.category_id = e.category_id
        end
      end
      transaction.save
    end
  end

  def enrich_past_transactions
    if self.is_auto == true
      transactions = Transaction.where("description = ?",self.description)
      if transactions.present? && self.category_id.present?
        transactions.each do |t|
          t.category_id = self.category_id
          t.save
        end
      end
      if transactions.present? && self.modifier_id.present?
        transactions.each do |t|
          unless t.transaction_modifiers.where("modifier_id = ?", self.modifier_id).present?
            m = TransactionModifier.new
            m.transaction_id = t.id
            m.modifier_id = self.modifier_id
            m.modifier_option_id = self.modifier_option_id
            m.origin = "auto"
            m.save
          end
          t.save
        end
      end
    end
  end
end
