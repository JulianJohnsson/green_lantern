class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.onboarded != true
      redirect_to '/onboarding'
    else
      @score = current_user.scores.last
      @rand = rand(2)

      total = 0
      count = 0
      User.all.onboarded.each do |user|
        total = total + user.scores.last.total
        count = count + 1
      end
      @carbone = @score.total * 1000/12
      @average = total / count * 1000/12

      @users = User.all.subscribed
      sum = 0
      @users.each do |user|
        sum = sum + user.scores.last.total
      end
      @cars = ((sum+12*6)*1000/12*0.01).to_i
    end
  end

end
