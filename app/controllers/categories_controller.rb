class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_onboarding

  def index
    @categories = Category.all.parent_categories
    @transactions_history = current_user.transactions.carbone_contribution
    @transactions = @transactions_history.month_ago(params[:month].to_i || 0)
    @carbone_by_parent_category = @categories.sort_by {|c| c.name}.map {|c| [c, @transactions.parent_category_id(c.id).sum(:carbone)]}
    @carbone_total = 0
    @carbone_by_parent_category.each do |c,v|
      @carbone_total = @carbone_total + v
    end
  end

  def show
    if current_user.scores.last.kind.to_sym == :static
      redirect_to "/scores/edit"
    end
    @category = Category.find(params[:id])
    @categories = Category.all.sub_categories(@category.id)
    @transactions = current_user.transactions.carbone_contribution.parent_category_id(@category.id).month_ago(params[:month].to_i || 0)

    @carbone_by_category = @categories.sort_by {|c| c.id}.map {|c| [c, @transactions.category_id(c.id).sum(:carbone)]}
    @carbone_category_total = @transactions.sum(:carbone)

    @colors = @categories.sort_by {|c| c.id}.map { |c| c.color }
  end

  def track
    @transactions_history = current_user.transactions.carbone_contribution

    @bridge = Bridge.find_by_user_id(current_user.id)
    @categories = Category.all.parent_categories.sort_by {|c| c.id}
    @score = current_user.scores.last
    @transaction_list = current_user.transactions.carbone_contribution.recent.order(date: :desc).first(5)

    if (Date.today - Date.today.beginning_of_month).to_i < 5 && params[:month] == nil
      params[:month] = 1
    end

    if @score.kind.to_sym == :dynamic
      @transactions = current_user.transactions.carbone_contribution.month_ago(params[:month].to_i || 0)
      @score.detail = @categories.sort_by {|c| c.id}.map {|c| @transactions.parent_category_id(c.id).sum(:carbone)*12/1000}
      @score.total = @score.detail.inject(0){|sum,x| sum.to_f + x.to_f }

      a1 = Equivalent.random("Tes dépenses en #{Category.find(@score.top_category[0]).name.downcase } des 30 derniers jours", @score.top_category[1])
      a2 = Equivalent.random("Ta dernière grosse dépense", @score.top_transaction[1])
      a3 = Equivalent.random("L'augmentation de tes dépenses en #{Category.find(@score.top_growth[0]).name.downcase } ce mois-ci", @score.top_growth[2])
      @analysis = [a1,a2,a3]

    end

    @data = []
    for i in 0..4
      @data = @data << [@categories[i].name, (@score.detail[i].to_f*1000/12).round(2)]
    end

    @average_history = AverageScore.where("score_kind = 1")

    AnalyticService.new.identify(current_user,request)
  end

end
