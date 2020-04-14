class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :account
  belongs_to :category
  has_many :comments
  has_many :transaction_modifiers

  before_save :calculate_carbone

  after_update :update_similar_transactions, if: :saved_change_to_category_id?
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
      self.carbone = self.amount * -1 * @category.coeff * modifier / self.people
    end
    self.set_parent_category
    self.set_accuracy
  end

  def update_similar_transactions
    if self.updated_by_user == true
      transactions = self.user.transactions.where("description = ?", self.description)
      to_check =  transactions.where("updated_by_user IS TRUE")
      to_update = transactions.where("updated_by_user IS NULL")
      # check if user has already categorized similar transaction 3 times with always the same category before mapping it automatically.
      if to_check.present? && to_check.count > 2 && to_check.count == to_check.where("category_id = ?",transactions.last.category_id).count
        to_update.each do |t|
          t.previous_category = t.category_id
          t.category_id = self.category_id
          t.updated_by_similar = true
          t.save
        end
      # Otherwise, category is just suggested for similar transactions.
      elsif to_update.present?
        to_update.each do |t|
          t.suggested_category_id = self.category_id
          t.save
        end
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
      if transactions.present? && transactions.count > 2 && transactions.count == transactions.where("category_id = ?",transactions.last.category_id).count
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

  def self.deduplicate
    transactions = self.group(:external_id).having('count("external_id") > 1').count(:external_id)
    transactions.each do |key,value|
      duplicates = Transaction.where(external_id: key)[1..value-1]
      puts "#{key} = #{duplicates.count}"
      duplicates.each(&:destroy)
    end
  end

end
