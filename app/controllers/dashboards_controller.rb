class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def index
    @score = current_user.scores.last
    total = 0
    count = 0
    User.all.onboarded.each do |user|
      total = total + user.scores.last.total
      count = count + 1
    end

    @carbone = @score.total * 1000/12
    @average = total / count * 1000/12

  end

end
