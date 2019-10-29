class MatchesController < ApplicationController
  before_action :authenticate_user!

  def new
    @match = Match.new
  end

  def index
    if params[:opponent]
      @opponent = Match.find(params[:opponent])
    else
      @opponent = Match.first
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
