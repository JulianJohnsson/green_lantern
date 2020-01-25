class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :comments

  before_save :calculate_carbone

  after_update :update_similar_transactions

  scope :week, -> {where("date > ?", 1.week.ago)}
  scope :previous_week, -> {where("date >= ? AND date < ?", 2.weeks.ago, 1.week.ago)}
  scope :recent, -> {where("date > ?", 1.month.ago)}
  scope :six_month, -> {where("date > ?", 6.months.ago)}
  scope :year, -> {where("date > ?", 1.year.ago)}

  scope :parent_category_id, -> (category_id) {where("parent_category_id = ?", category_id)}
  scope :category_id, -> (category_id) {where("category_id = ?", category_id)}

  scope :month_ago, -> (int) {where("date >= ? AND date <= ?", int.months.ago.beginning_of_month, int.months.ago.end_of_month)}
  scope :month_to_date, -> (int) {where("date >= ? AND date <= ?", int.months.ago.beginning_of_month, int.months.ago)}

  scope :year_to_date, -> (int) {where("date >= ? AND date <= ?", int.years.ago.beginning_of_year, int.years.ago)}

  scope :carbone_contribution, -> {where "carbone > 0"}

  def calculate_carbone
    self.refine_category
    @category = Category.find(category_id)
    unless self.user.user_modifiers.category_id(category_id) == []
      modifier = self.user.user_modifiers.category_id(category_id).last.carbone_modifier
    else
      modifier = 0
    end
    self.carbone = 0
    unless @category.coeff == nil
      self.carbone = self.amount * -1 * @category.coeff * (1 + modifier)
    end
    self.set_parent_category
  end

  def update_similar_transactions
    if self.updated_by_user == true
      transactions = self.user.transactions
      to_update = transactions.where("description = ? AND updated_by_user IS NOT TRUE", self.description)
      to_update.each do |t|
        t.previous_category = t.category_id
        t.category_id = self.category_id
        t.updated_by_similar = true
        t.save
      end
    end
  end

  def set_parent_category
    until @category.parent_id == 0
      @category = Category.find(@category.parent_id)
    end
    self.parent_category_id = @category.id
  end

  def refine_category
    if self.category_id == 115
      transactions = self.user.transactions.where("description = ? AND updated_by_user IS TRUE", self.description)
      if transactions.present?
        self.category_id = transactions.last.category_id
        self.updated_by_similar = true
      elsif Transaction.all.where("description = ? AND updated_by_user IS TRUE", self.description).present?
        self.suggested_category_id = Transaction.all.where("description = ? AND updated_by_user IS TRUE", self.description).last.category_id
      end
    end
  end

end
