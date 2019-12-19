class WeeklyScoreUpdateJob < ApplicationJob

  def perform
    @bridges = Bridge.all.to_sync
    @bridges.each do |bridge|
      user = bridge.user
      if user.transactions.week.carbone_contribution.present?
        UserMailer.weekly_score_update(user).deliver_later
      end
    end
  end

end
