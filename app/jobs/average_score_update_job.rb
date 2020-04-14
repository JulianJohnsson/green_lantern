class AverageScoreUpdateJob < ApplicationJob

  def perform
    AverageScore.create_average(0.day.ago)
    @avg = AverageScore.all.where("score_kind = 1").last
    @avg.update_week_history
  end

end
