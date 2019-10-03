class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = Category.all.parent_categories
    @transactions = current_user.transactions.carbone_contribution.month_ago(params[:month].to_i || 0)
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
    @transactions = current_user.transactions.carbone_contribution
    @bridge = Bridge.find_by_user_id(current_user.id)
    @categories = Category.all.parent_categories

    if (Date.today - Date.today.beginning_of_month).to_i < 5
      # accomodate empty beginning of month by displaying previous month
      @current_month_count = @transactions.month_ago(1).sum(:carbone)
      @last_month_count = @transactions.month_ago(2).sum(:carbone)
      @carbone_by_parent_category = @categories.map{|c| [c, @transactions.parent_category_id(c.id).month_ago(1).sum(:carbone)]}.to_h
    else
      @current_month_count = @transactions.month_to_date(0).sum(:carbone)
      @last_month_count = @transactions.month_to_date(1).sum(:carbone)
      @carbone_by_parent_category = @categories.map{|c| [c, @transactions.parent_category_id(c.id).month_ago(0).sum(:carbone)]}.to_h
    end

    @current_year_count = @transactions.year_to_date(0).sum(:carbone)
    @last_year_count = @transactions.year_to_date(1).sum(:carbone)

    @top_parent_category = {@carbone_by_parent_category.key(@carbone_by_parent_category.values.max) => @carbone_by_parent_category.values.max }

    @carbone_by_category = Category.all.map{|c| [c, @transactions.recent.category_id(c.id).sum(:carbone)]}.to_h
    @top_category = {@carbone_by_category.key(@carbone_by_category.values.max) => @carbone_by_category.values.max }

    @top_transaction = @transactions.recent.order("carbone DESC").first

    @growth_by_category = Category.all.map{|c| [c, 100*(@transactions.recent.category_id(c.id).sum(:carbone) - @transactions.where("date > ? AND date <= ?", 2.months.ago, 1.month.ago).category_id(c.id).sum(:carbone)) / @transactions.where("date > ? AND date <= ?", 2.months.ago, 1.month.ago).category_id(c.id).sum(:carbone)]}.to_h
    @top_growth = {@growth_by_category.key(@growth_by_category.values.reject(&:nan?).reject(&:infinite?).max) => @growth_by_category.values.reject(&:nan?).reject(&:infinite?).max }

    # specific transactions object for dynamic category table display
    @transactions_2 = @transactions.month_ago(params[:month].to_i || 0)
    @carbone_by_parent_category_2 = @categories.sort_by {|c| c.name}.map {|c| [c, @transactions_2.parent_category_id(c.id).sum(:carbone)]}
    @carbone_total = 0
    @carbone_by_parent_category_2.each do |c,v|
      @carbone_total = @carbone_total + v
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
