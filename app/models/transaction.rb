class Transaction < ApplicationRecord
  belongs_to :user
  before_save :calculate_carbone

  scope :recent, -> {where("date > ?", 1.month.ago)}
  scope :year, -> {where("date > ?", 1.year.ago)}
  scope :month_to_date, -> {where("date >= ?", Date.today.beginning_of_month)}

  scope :parent_category_id, -> (category_id) {where("parent_category_id = ?", category_id)}
  scope :category_id, -> (category_id) {where("category_id = ?", category_id)}

  scope :month_ago, -> (int) {where("date >= ? AND date <= ?", int.months.ago.beginning_of_month, int.months.ago.end_of_month)}
  scope :carbone_contribution, -> {where "carbone > 0"}

  def calculate_carbone
    @category = Category.find_by_external_id(category_id)
    self.carbone = 0
    unless @category.coeff == nil
      self.carbone = self.amount * -1 * @category.coeff
    end
    until @category.parent_id == 0
      @category = Category.find_by_external_id(@category.parent_id)
    end
    self.parent_category_id = @category.external_id
  end
end
