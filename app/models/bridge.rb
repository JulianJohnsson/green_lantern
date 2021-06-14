class Bridge < ApplicationRecord
  belongs_to :user
  before_destroy :delete_account

  scope :to_sync, -> {where("bank_connected = TRUE")}

  def verify_bridge_url(user)
    self.refresh(user)
    response = RestClient::Request.execute(method: :get,
      url: "https://sync.bankin.com/v2/connect/users/email/confirmation/url?#{credential}",
      headers: {'Bankin-Version' => '2018-06-15',
      'Authorization' => "Bearer #{token}"}
    )

    case response.code when 200
      json = JSON.parse response
      redirect_url = json['redirect_url']
    end
    redirect_url
  end

  def add_item_url(user)
    self.refresh(user)
    if user.context == 'lbp'
      @url = "https://sync.bankin.com/v2/connect/items/add/url?#{credential}&prefill_email=#{user.email}&bank_id=17"
    else
      @url = "https://sync.bankin.com/v2/connect/items/add/url?#{credential}&prefill_email=#{user.email}"
    end
    response = RestClient::Request.execute(method: :get,
      url: @url,
      headers: {'Bankin-Version' => '2018-06-15',
      'Authorization' => "Bearer #{token}"}
    )

    case response.code when 200
      json = JSON.parse response
      redirect_url = json['redirect_url']
    end
    redirect_url
  end

  def edit_item_url(user, item_id)
    self.refresh(user)
    response = RestClient::Request.execute(method: :get,
      url: "https://sync.bankin.com/v2/connect/items/edit/url?#{credential}&item_id=#{item_id}",
      headers: {'Bankin-Version' => '2018-06-15',
      'Authorization' => "Bearer #{token}"}
    )

    case response.code when 200
      json = JSON.parse response
      redirect_url = json['redirect_url']
    end
    redirect_url
  end

  def create_transactions(user)
    json = self.list_transactions(user)
    json['resources'].each do |transaction|
      @transaction = Transaction.find_or_create_by(external_id: transaction['id']) do |t|
        t.user_id = user.id
        t.amount = transaction['amount']
        t.description = transaction['description']
        t.raw_description = transaction['raw_description']
        t.date = transaction['date']
        account = Account.find_or_create_by(external_id: transaction['account']['id']) do |a|
          a.user_id = user.id
        end
        t.account_id = account.id
        t.people = account.people || 1
        if BankinCategory.find_by_bankin_id(transaction['category']['id'].to_i).present?
          t.category_id = BankinCategory.find_by_bankin_id(transaction['category']['id'].to_i).category_id
        else
          t.category_id = 115
        end
      end
      @transaction.save
    end
    self.last_sync_at = Time.now.to_datetime
    self.save
  end

  def list_transactions(user)
    self.refresh(user)
    if self.last_sync_at == nil
      response = RestClient::Request.execute(method: :get,
        url: "https://sync.bankin.com/v2/transactions?limit=500&#{credential}",
        headers: {'Bankin-Version' => '2018-06-15',
        'Authorization' => "Bearer #{token}"}
      )
    else
      response = RestClient::Request.execute(method: :get,
        url: "https://sync.bankin.com/v2/transactions/updated?since=#{last_sync_at}&limit=500&#{credential}",
        headers: {'Bankin-Version' => '2018-06-15',
        'Authorization' => "Bearer #{token}"}
      )
    end

    case response.code when 200
      json = JSON.parse response
    end
    list = json

    until json['pagination']['next_uri'] == nil do
      response = RestClient::Request.execute(method: :get,
      url: "https://sync.bankin.com#{json['pagination']['next_uri']}&#{credential}",
      headers: {'Bankin-Version' => '2018-06-15',
        'Authorization' => "Bearer #{token}"}
      )

      case response.code when 200
        json = JSON.parse response
      end
      list['resources'] = list['resources'].concat(json['resources'])
    end
    list
  end

  def list_accounts(user)
    self.refresh(user)
    response = RestClient::Request.execute(method: :get,
      url: "https://sync.bankin.com/v2/accounts?limit=500&#{credential}",
      headers: {
        'Bankin-Version' => '2018-06-15',
        'Authorization' => "Bearer #{token}"
      }
    )

    case response.code when 200
      json = JSON.parse response
    end

    list = json['resources']

  end

  def list_items(user)
    self.refresh(user)
    response = RestClient::Request.execute(method: :get,
      url: "https://sync.bankin.com/v2/items?limit=500&#{credential}",
      headers: {'Bankin-Version' => '2018-06-15',
      'Authorization' => "Bearer #{token}"}
    )

    case response.code when 200
      json = JSON.parse response
    end

    list = json['resources']

  end

  def refresh(user)
    RestClient.proxy = ENV["FIXIE_URL"]

    unless self.uuid
      self.set_credential
      self.create_account(user)
      self.save
    end
    if self.expires_at.nil?
      self.authenticate(user)
      self.save
    elsif self.expires_at <= Time.now.to_datetime
      self.authenticate(user)
      self.save
    end
  end

  def create_account(user)
    response = RestClient::Request.execute(method: :post,
      url: "https://sync.bankin.com/v2/users?email=#{user.email}&password=#{user.email}_#{user.id}&#{credential}",
      headers: {"Bankin-Version" => "2018-06-15"}
    )

    case response.code when 201
      json = JSON.parse response
      self.uuid = json['uuid']
    end
  end

  def delete_account
    return unless uuid.present?

    self.refresh(user)
    response = RestClient::Request.execute(method: :delete,
      url: "https://sync.bankin.com/v2/users/#{uuid}?password=#{user.email}_#{user.id}",
      headers: {
        'Bankin-Version' => '2019-02-18',
        'Client-Id' => Rails.application.credentials[:bridge_4][Rails.env.to_sym][:client_id],
        'Client-Secret' => Rails.application.credentials[:bridge_4][Rails.env.to_sym][:client_secret],
        'Authorization' => "Bearer #{token}"
      }
    )
    case response.code when 204
      self.uuid = nil
      self.save
    end
  end

  def authenticate(user)
    response = RestClient::Request.execute(method: :post,
      url: "https://sync.bankin.com/v2/authenticate?email=#{user.email}&password=#{user.email}_#{user.id}&#{credential}",
      headers: {'Bankin-Version' => '2018-06-15'}
    )

    case response.code when 200
      json = JSON.parse response
      self.token = json['access_token']
      self.expires_at = json['expires_at']
    end
  end

  def set_credential
    if Bridge.all.last.present? && Bridge.all.last.id < 147
      client = Rails.application.credentials[:bridge][Rails.env.to_sym][:client_id]
      secret = Rails.application.credentials[:bridge][Rails.env.to_sym][:client_secret]
    else
      client = Rails.application.credentials[:bridge_4][Rails.env.to_sym][:client_id]
      secret = Rails.application.credentials[:bridge_4][Rails.env.to_sym][:client_secret]
    end
    self.credential = "client_id=#{client}&client_secret=#{secret}"
  end

end
