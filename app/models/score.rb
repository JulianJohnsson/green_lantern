class Score < ApplicationRecord
  belongs_to :user
  belongs_to :country

  before_create :set_default
  before_save :calculate_score

  enum main_transport_mode: [:voiture_classique, :voiture_électrique, :moto_ou_scooter, :transports_en_commun, :vélo_ou_marche]
  enum regime: [:végétalien, :végétarien, :flexitarien, :moyen, :viandard]
  enum kind: [:static, :dynamic]

  def set_default
    country = Country.find(self.country_id)
    self.detail = country.detail
    if self.kind == nil
      self.kind = :static
    end
    self.sum_categories
  end

  def calculate_score
    case self.kind.to_sym when :static
      if self.main_transport_mode_changed? || self.long_flights_changed? || self.short_flights_changed?
        self.set_transport_score
      end
      if self.house_size_changed?
        self.set_house_score
      end
      if self.regime_changed?
        self.set_food_score
      end
    when :dynamic
      categories = Category.all.parent_categories
      user = self.user
      first_transaction_date = user.transactions.order(date: :asc).first.date
      days = [365, (DateTime.now.to_date - first_transaction_date).to_i].min
      for i in 0..4
        self.detail[i] = user.transactions.carbone_contribution.parent_category_id(categories[i].id).year.sum(:carbone) * 365 / (days*1000)
        self.recent_detail[i] = user.transactions.carbone_contribution.parent_category_id(categories[i].id).recent.sum(:carbone) * 12 / 1000
      end
      self.calculate_trends
    end
    self.sum_categories
  end

  def sum_categories
    self.total = self.detail.inject(0){|sum,x| sum.to_f + x.to_f }
    if self.kind.to_sym == :dynamic
      self.recent_total = self.recent_detail.inject(0){|sum,x| sum.to_f + x.to_f }
    end
  end

  def set_transport_score
    base = Country.find(country_id).detail[0].to_f
    case self.main_transport_mode.to_sym when :voiture_classique
      modifier = 0
    when :voiture_électrique
      modifier = -0.7
    when :moto_ou_scooter
      modifier = -0.5
    when :transports_en_commun
      modifier = -0.62
    when :vélo_ou_marche
      modifier = -0.95
    end
    self.detail[0] = base * (1 + modifier) + 1.37*(self.long_flights || 0) + 0.34*(self.short_flights || 0)
  end

  def set_house_score
    base = Country.find(country_id).detail[1].to_f
    self.detail[1] = base * self.house_size / Country.find(country_id).house_size.to_f
  end

  def set_food_score
    base = Country.find(country_id).detail[4].to_f
    case self.regime.to_sym when :moyen
      modifier = 0
    when :végétalien
      modifier = -0.463
    when :végétarien
      modifier = -0.3955
    when :flexitarien
      modifier = -0.2553
    when :viandard
      modifier = 0.5093
    end
    self.detail[4] = base * (1 + modifier)
  end

  def calculate_trends
    transactions = self.user.transactions.carbone_contribution
    carbone_by_category = Category.all.map{|c| [c.id, transactions.recent.category_id(c.id).sum(:carbone)]}.to_h
    top_category = [carbone_by_category.key(carbone_by_category.values.max) , carbone_by_category.values.max ]
    self.top_category = top_category

    top_transaction = transactions.recent.order("carbone DESC").first
    self.top_transaction = [top_transaction.description, top_transaction.carbone]

    growth_by_category = Category.all.map{|c| [c.id, 100*(transactions.recent.category_id(c.id).sum(:carbone) - transactions.where("date > ? AND date <= ?", 2.months.ago, 1.month.ago).category_id(c.id).sum(:carbone)) / transactions.where("date > ? AND date <= ?", 2.months.ago, 1.month.ago).category_id(c.id).sum(:carbone)]}.to_h
    top_growth = [growth_by_category.key(growth_by_category.values.reject(&:nan?).reject(&:infinite?).max), growth_by_category.values.reject(&:nan?).reject(&:infinite?).max ]
    self.top_growth = top_growth
  end
end
