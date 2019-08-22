class CategoriesController < ApplicationController
  def index
    @parent_categories = Category.where("parent_id = 0")
    @transactions = current_user.transactions.month_to_date
  end
end
