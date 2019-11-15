class CategoriesController < ApplicationController
  before_action :authenticate_user!

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
    @category = Category.find(params[:id])
    @categories = Category.all.sub_categories(@category.id)
    @transactions = current_user.transactions.carbone_contribution.parent_category_id(@category.id).month_ago(params[:month].to_i || 0)

    @carbone_by_category = @categories.sort_by {|c| c.id}.map {|c| [c, @transactions.category_id(c.id).sum(:carbone)]}
    @carbone_category_total = @transactions.sum(:carbone)

    @colors = @categories.sort_by {|c| c.id}.map { |c| c.color }
  end

  def track
    @bridge = Bridge.find_by_user_id(current_user.id)
    @categories = Category.all.parent_categories.sort_by {|c| c.id}
    @score = current_user.scores.last
    @transactions = current_user.transactions.carbone_contribution.recent
    @transaction_list = @transactions.order(date: :desc).first(6)
    if params[:month].present?
      @transactions = current_user.transactions.carbone_contribution.month_ago(params[:month].to_i)
      @score.detail = @categories.sort_by {|c| c.id}.map {|c| @transactions.parent_category_id(c.id).sum(:carbone)*12/1000}
      @score.total = @score.detail.inject(0){|sum,x| sum.to_f + x.to_f }
    end

    @data = []
    for i in 0..4
      @data = @data << [@categories[i].name, @score.detail[i].to_f*1000/12]
    end

    AnalyticService.new.identify(current_user,request)
  end

  def compare
    @categories = Category.all.parent_categories
    @preference = current_user.preferences.last
    @carbone_count = current_user.transactions.month_ago(params[:month].to_i || 0).sum(:carbone)
    @carbone_average = Transaction.all.carbone_contribution.month_ago(params[:month].to_i || 0).sum(:carbone) / Transaction.all.carbone_contribution.month_ago(params[:month].to_i || 0).distinct.count(:user_id)
    @my_carbone =  @categories.sort_by {|c| c.name}.map {|c| [c , current_user.transactions.carbone_contribution.parent_category_id(c.id).month_ago(params[:month].to_i || 0).sum(:carbone)]}
    @average_carbone = @categories.sort_by {|c| c.name}.map {|c| [c , Transaction.all.carbone_contribution.parent_category_id(c.id).month_ago(params[:month].to_i || 0).sum(:carbone) / Transaction.all.carbone_contribution.parent_category_id(c.id).month_ago(params[:month].to_i || 0).distinct.count(:user_id)]}
  end

end
