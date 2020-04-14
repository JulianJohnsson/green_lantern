class Account < ApplicationRecord
  belongs_to :user
  has_many :transactions

  def self.refresh_accounts(user)
    accounts = user.accounts
    if accounts == [] || accounts.last.updated_at < 1.day.ago
      bridge = Bridge.find_by_user_id(user.id)
      list = bridge.list_accounts(user)
      list.each do |account|
        @account = Account.find_or_create_by(external_id: account['id'])
        @account.name = account['name']
        @account.status = account['status']
        @account.user_id = user.id
        @account.item_id = account['item']['id']
        @account.kind = account['type']
        @account.last_sync_at = account['updated_at'].to_datetime
        @account.save
      end
    end
  end

end
