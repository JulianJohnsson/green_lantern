class MatchesController < ApplicationController
  before_action :authenticate_user!

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

    @match_data = @opponent.get_match_data(current_user)

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
          maxTicksLimit: 5
        }
      }

    }

  end

end
