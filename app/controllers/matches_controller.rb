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

    @data = {
      labels: ["🚘", "🏠", "💈", "🛍", "🍕"],
      datasets: [
        { label: 'Toi', data: @carbone_by_parent_category.map { |c,v| v }, borderColor: "#6C63FF" },
        { label: @opponent.name, data: @opponent.data, borderColor: "#FF8550" }
      ]
    }
    @options = {
      legend: {
        display: false
      },
      scale: {
        pointLabels: {
          fontSize: 28
        }
      }
    }

  end

end
