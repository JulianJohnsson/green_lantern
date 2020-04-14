class TransactionsAccountEnrichmentJob < ApplicationJob

  def perform
    @bridges = Bridge.all.to_sync
    @bridges.each do |bridge|
      bridge.last_sync_at = nil
      bridge.save
      bridge.create_transactions(bridge.user)
    end
  end

end
