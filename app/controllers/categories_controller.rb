class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = Category.all.parent_categories
    @carbone_by_parent_category = @categories.sort_by {|c| c.name}.map {|c| [c.name , current_user.transactions.carbone_contribution.parent_category_id(c.external_id).month_ago(params[:month].to_i || 0).sum(:carbone)]}
    @transactions = current_user.transactions.carbone_contribution.month_ago(params[:month].to_i || 0).where("parent_category_id != 1")
  end

  def show
    @category = Category.find(params[:id])
    # @carbone_by_subcategory = Category.all.find_by_parent_id(@category.external_id).map {|c| [c.name, current_user.transactions.carbone_contribution.find_by_external_id(c.external_id).month_ago(params[:month].to_i || 0).sum(:carbone)]}
    @transactions = current_user.transactions.carbone_contribution.parent_category_id(@category.external_id).month_ago(params[:month].to_i || 0)
  end

  def compare
    @categories = Category.all.parent_categories
    #@carbone_by_category = @categories.sort_by {|c| c.name}.map {|c| [c.name , current_user.transactions.carbone_contribution.parent_category_id(c.external_id).month_ago(params[:month].to_i || 0).sum(:carbone)]}
    #@avg_carbone_by_category = @categories.sort_by {|c| c.name}.map {|c| [c.name , Transaction.all.carbone_contribution.parent_category_id(c.external_id).month_ago(params[:month].to_i || 0).sum(:carbone) / Transaction.all.carbone_contribution.parent_category_id(c.external_id).month_ago(params[:month].to_i || 0).distinct.count(:user_id)]}
  end
end
