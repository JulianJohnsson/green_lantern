class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :comments
  has_many :transaction_modifiers

  before_save :calculate_carbone

  after_update :update_similar_transactions
  after_update :update_score, if: :saved_change_to_carbone?

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
    if self.transaction_modifiers == [] && self.user.user_modifiers.category_id(category_id).present?
      modifier = 1+ self.user.user_modifiers.category_id(category_id).last.carbone_modifier
    else
      modifier = 1
      self.transaction_modifiers.each do |m|
        modifier = modifier * (1 + m.coeff)
      end
    end
    self.carbone = 0
    unless @category.coeff == nil
      self.carbone = self.amount * -1 * @category.coeff * modifier
    end
    self.set_parent_category
    self.set_accuracy
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

  def set_accuracy
    if self.category_id == 115
      self.accuracy = 0
    elsif self.category_id == self.parent_category_id
      self.accuracy = 1
    elsif (self.category.modifiers.present? || self.category.parent.modifiers.present?) && self.transaction_modifiers == []
      self.accuracy = 2
    else
      self.accuracy = 3
    end
  end

  def update_score
    ScoreUpdateJob.perform_later(self.user.scores.last)
  end

end
