class Account < ApplicationRecord
  belongs_to :user
  has_many :transactions

  after_save :update_transactions, if: :saved_change_to_people?
  after_save :check_status, if: :saved_change_to_status?
  after_save :hide_transactions, if: :saved_change_to_active?

  scope :active, -> { where("active = true") }

  def self.refresh_accounts(user)
    accounts = user.accounts
    if accounts == [] || accounts.last.updated_at < 1.hour.ago || accounts.where("item_id is null").present?
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

  def check_status
    if [1003,402,429,1010,1009].include?(status.to_i) && (self.user.notification_preference.refresh_bridge_date == nil || self.user.notification_preference.refresh_bridge_date < 1.day.ago)
      if status_info.present?
        RefreshBridgeJob.perform_later(self)
        self.user.notification_preference.update(refresh_bridge_date: 0.day.ago)
      else
        case status when 429
          text = "Please activate your account on your bank's website or app."
        when 1010
          text = "Thanks for filling in the strong customer authentification (SMS, notification, etc.) provided by your bank."
        when 402
          text = "The credentials you used don't allow us to synchronize your accounts. Please edit them (check for any typo)."
        when 1003
          text = "There's a synchronisation error with your accounts. Click here to learn more."
        end
        self.status_info = text
        self.save
        RefreshBridgeJob.perform_later(self)
        self.user.notification_preference.update(refresh_bridge_date: 0.day.ago)
      end
    end
  end

  def hide_transactions
    self.transactions.each { |t| t.destroy }
  end

end
