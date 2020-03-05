class AverageScoreUpdateJob < ApplicationJob

  def perform
    AverageScore.create_average(0.day.ago)
  end

end
