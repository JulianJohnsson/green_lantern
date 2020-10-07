class VisitorsController < ApplicationController
  def index
    @average_history = AverageScore.where("score_kind = 1").sort_by {|c| c.created_at}
    @categories = Category.all.parent_categories.sort_by {|c| c.id}
    @week = @average_history.last
    @previous = @average_history.last(2).first
    @data = []
    for i in 0..4
      @data = @data << [@categories[i].name, (@week.week_detail[i].to_f*1000/12).round(2)]
    end
    render :layout => 'pages'
  end

  def api
    data = File.read("classifier.dat")
    trained_classifier = Marshal.load data
    @t = Transaction.order('RANDOM()').first
    @guess = trained_classifier.classify @t.description
    render :layout => false
  end
end
