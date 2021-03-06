class TransactionFetcherJob < ApplicationJob
  queue_as :default

  def perform(user)
    Account.refresh_accounts(user)
    @bridge = Bridge.find_by_user_id(user.id)
    @bridge.create_transactions(user)
    if user.transactions.present?
      @score = Score.find_by_user_id(user.id)
      @score.kind = :dynamic
      @score.refresh_reductions
      @score.save
    end
  end

end
