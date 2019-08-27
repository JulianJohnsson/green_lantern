class CategoriesController < ApplicationController
  def index
    @categories = Category.all.parent_categories
    @carbone_by_parent_category = @categories.sort_by {|c| c.name}.map {|c| [c.name , current_user.transactions.carbone_contribution.parent_category_id(c.external_id).month_ago(params[:month].to_i || 0).sum(:carbone)]}
    @transactions = current_user.transactions.carbone_contribution.month_ago(params[:month].to_i || 0)
  end
end
