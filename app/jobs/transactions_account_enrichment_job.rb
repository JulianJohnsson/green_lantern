class TransactionsAccountEnrichmentJob < ApplicationJob

  def perform
    @bridges = Bridge.all.to_sync
    @bridges.each do |bridge|
      bridge.last_sync_at = nil
      TransactionFetcherJob.perform_later(bridge.user)
    end
  end

end
