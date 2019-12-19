class BridgeJob < ApplicationJob

  def perform
    @bridges = Bridge.all.to_sync
    @bridges.each do |bridge|
      TransactionFetcherJob.perform_later(bridge.user)
    end
  end

end
