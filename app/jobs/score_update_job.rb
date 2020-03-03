class ScoreUpdateJob < ApplicationJob

  def perform(score)
    score.save
  end

end
