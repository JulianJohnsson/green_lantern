class CategoriesController < ApplicationController
  def index
    @transactions = current_user.transactions.carbone_contribution.month_ago(params[:month].to_i || 0)
  end
end
