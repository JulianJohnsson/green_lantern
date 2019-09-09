class Comment < ApplicationRecord
  belongs_to :my_transaction, class_name: "Transaction", foreign_key: "transaction_id"

  after_create_commit :notify_comment

  def notify_comment
    AnalyticService.new.track('Transaction commented',
      {
        transaction_id: self.my_transaction.id,
        category_id: self.my_transaction.category_id,
        parent_id: self.my_transaction.parent_category_id
      },
        self.my_transaction.user
    )
    UserMailer.new_comment(self).deliver_later
  end
end
