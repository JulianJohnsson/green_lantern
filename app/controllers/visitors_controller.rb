class VisitorsController < ApplicationController
  def index
    @average_history = AverageScore.where("score_kind = 1")
    @average_history.each do |average|
      average.week_total = average.week_total.to_f * 1000 / 12
      for i in 0..4
        average.week_detail[i] = average.week_detail[i].to_f * 1000 /12
      end
    end
    @categories = Category.all.parent_categories.sort_by {|c| c.id}

  end
end
