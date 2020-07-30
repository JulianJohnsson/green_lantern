class VisitorsController < ApplicationController
  def index
    @average_history = AverageScore.where("score_kind = 1").sort_by {|c| c.created_at}
    @categories = Category.all.parent_categories.sort_by {|c| c.id}
    @week = @average_history.last
    @rand = rand(3)
    render :layout => 'pages'

  end
end
