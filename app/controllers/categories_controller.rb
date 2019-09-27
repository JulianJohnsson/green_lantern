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

  def compare
    @categories = Category.all.parent_categories
    @preference = current_user.preferences.last
    @carbone_count = current_user.transactions.month_ago(params[:month].to_i || 0).sum(:carbone)
    @carbone_average = Transaction.all.carbone_contribution.month_ago(params[:month].to_i || 0).sum(:carbone) / Transaction.all.carbone_contribution.month_ago(params[:month].to_i || 0).distinct.count(:user_id)
    @my_carbone =  @categories.sort_by {|c| c.name}.map {|c| [c , current_user.transactions.carbone_contribution.parent_category_id(c.id).month_ago(params[:month].to_i || 0).sum(:carbone)]}
    @average_carbone = @categories.sort_by {|c| c.name}.map {|c| [c , Transaction.all.carbone_contribution.parent_category_id(c.id).month_ago(params[:month].to_i || 0).sum(:carbone) / Transaction.all.carbone_contribution.parent_category_id(c.id).month_ago(params[:month].to_i || 0).distinct.count(:user_id)]}
  end
end
