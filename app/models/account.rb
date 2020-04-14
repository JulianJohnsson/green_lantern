class Account < ApplicationRecord
  belongs_to :user
  has_many :transactions

  after_save :update_transactions, if: :saved_change_to_people?

  def self.refresh_accounts(user)
    accounts = user.accounts
    if accounts == [] || accounts.last.updated_at < 1.hour.ago
      bridge = Bridge.find_by_user_id(user.id)
      list = bridge.list_accounts(user)
      list.each do |account|
        @account = Account.find_or_create_by(external_id: account['id'])
        @account.name = account['name']
        @account.status = account['status']
        @account.status_info = account['status_code_description']
        @account.user_id = user.id
        @account.item_id = account['item']['id']
        @account.kind = account['type']
        @account.last_sync_at = account['updated_at'].to_datetime
        @account.save
      end
    end
  end

  def update_transactions
    self.transactions.each do |transaction|
      transaction.people = self.people
      transaction.save
    end
  end

end
