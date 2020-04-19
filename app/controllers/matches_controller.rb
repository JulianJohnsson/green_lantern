class MatchesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_onboarding

  def new
    @match = Match.new
  end

  def index
    ab_finished(:score_update_in_onboarding)

    if params[:opponent]
      @opponent = Match.find(params[:opponent])
      AnalyticService.new.track('Changed Match Opponent', nil, current_user)
    else
      @opponent = Match.first
      AnalyticService.new.track('Displayed Match', nil, current_user)
    end
    AnalyticService.new.identify(current_user,request)

    @match_data = @opponent.get_match_data(current_user)

    unless current_user.badges.include?(Badge.find(12))
      if @match_data[3].to_f < @match_data[4].to_f
        current_user.badges <<  Badge.find(12)
      end
    end

    @options = {
      legend: {
        display: false
      },
      scale: {
        pointLabels: {
          fontSize: 28
        },
        gridLines: {
          display: true,
          color: 'rgba(0, 0, 0, 0.05)',
          tickMarkLength: 10
        },
        ticks: {
          suggestedMin: 0,
          maxTicksLimit: 5
        }
      }

    }

  end

  def trends
    @average_history = AverageScore.where("score_kind = 1")

    @score = current_user.scores.last.recent_total*1000/12
    @badge = current_user.set_level[2] * -10
    @friends = (User.where("invited_by_id = ?", current_user.id).count) * -20
    @project = (current_user.subscription_price||0) * -50

    @array = []
    @scores = Score.all.dynamic.where("recent_total > 0")
    @scores.each do |score|
      user = score.user
      id = user.id
      name = (user.name||"") + " (" + user.email + ")"
      city = user.city
      points = user.scores.last.recent_total*1000/12 + (user.set_level[2]||0) * -10 + ((User.where("invited_by_id = ?", user.id).count)||0) * -20 + (user.subscription_price if user.subscribed||0) * -50
      @array << { :id => id, :name => name, :points => points, :city => city }
    end
    @ranking = @array.sort_by { |hsh| hsh[:points] }
  end

end
