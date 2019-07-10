class TransactionFetcherJob < ApplicationJob
  queue_as :default

  def perform(user)
    @bridge = Bridge.find_by_user_id(user.id)
    @bridge.create_transactions(user)
  end

end
