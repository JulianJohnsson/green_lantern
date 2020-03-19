class MatchesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_onboarding

  def new
    @match = Match.new
  end

  def index
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

end
