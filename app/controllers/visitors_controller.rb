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
    @chart_data = [
      {
        name: @categories[0].name,
        data: @average_history.map { |average| [average.created_at, average.week_detail[0].to_f] },
        dataset: { backgroundColor: @categories[0].color, borderColor: @categories[0].color},
        color: @categories[0].color
      },
      {
        name: @categories[1].name,
        data: @average_history.map { |average| [average.created_at, average.week_detail[1].to_f] },
        dataset: { backgroundColor: @categories[1].color, borderColor: @categories[1].color},
        color: @categories[1].color
      },
      {
        name: @categories[2].name,
        data: @average_history.map { |average| [average.created_at, average.week_detail[2].to_f] },
        dataset: { backgroundColor: @categories[2].color, borderColor: @categories[2].color},
        color: @categories[2].color
      },
      {
        name: @categories[3].name,
        data: @average_history.map { |average| [average.created_at, average.week_detail[3].to_f] },
        dataset: { backgroundColor: @categories[3].color, borderColor: @categories[3].color},
        color: @categories[3].color
      },
      {
        name: @categories[4].name,
        data: @average_history.map { |average| [average.created_at, average.week_detail[4].to_f] },
        dataset: { backgroundColor: @categories[4].color, borderColor: @categories[4].color},
        color: @categories[4].color
      }
    ]
  end
end
