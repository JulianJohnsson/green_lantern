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

    @categories = Category.all.parent_categories
    @transactions = current_user.transactions.recent.carbone_contribution
    @carbone_by_parent_category = @categories.sort_by {|c| c.id}.map {|c| [c, @transactions.parent_category_id(c.id).sum(:carbone)]}
    @carbone_total = 0
    @carbone_by_parent_category.each do |c,v|
      @carbone_total = @carbone_total + v
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
