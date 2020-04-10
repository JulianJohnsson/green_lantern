class Score < ApplicationRecord
  belongs_to :user
  belongs_to :country

  before_create :set_default
  before_create :set_match
  before_save :calculate_score
  after_update :update_onboarding, if: :saved_change_to_regime? || :saved_change_to_kind?
  #after_commit :refresh_reductions, if: :saved_change_to_detail?

  enum main_transport_mode: [:voiture_classique, :voiture_électrique, :moto_ou_scooter, :transports_en_commun, :vélo_ou_marche]
  enum regime: [:végétalien, :végétarien, :flexitarien, :moyen, :viandard]
  enum kind: [:static, :dynamic]

  enum energy: [:je_ne_sais_pas, :électricité, :gaz, :fioul, :bois]
  enum enr: [:inconnu, :partiellement_renouvelable, :fortement_renouvelable]

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
      if self.main_transport_mode_changed? || self.long_flights_changed? || self.short_flights_changed? || self.week_basic_car_changed? || self.week_electric_car_changed? || self.week_moto_changed? || self.week_public_trans_changed?
        self.set_transport_score
      end
      if self.house_size_changed? || self.energy_changed? || self.enr_changed? || self.house_people_changed?
        self.set_house_score
      end
      if self.regime_changed? || self.redmeat_changed? || self.poultry_changed? || self.dairy_changed?
        self.set_food_score
      end
      if self.services_health_changed? || self.services_plans_changed? || self.services_others_changed?
        self.set_services_score
      end
      if self.goods_furnitures_changed? || self.goods_clothes_changed? || self.goods_others_changed?
        self.set_goods_score
      end
    when :dynamic
      categories = Category.all.parent_categories.sort_by {|c| c.id}
      user = self.user
      first_transaction_date = user.transactions.order(date: :asc).first.date
      days = [365, (DateTime.now.to_date - first_transaction_date).to_i].min
      for i in 0..4
        self.detail[i] = user.transactions.carbone_contribution.parent_category_id(categories[i].id).year.sum(:carbone) * 365 / (days*1000)
        self.recent_detail[i] = user.transactions.carbone_contribution.parent_category_id(categories[i].id).recent.sum(:carbone) * 12 / 1000
      end
      # à mettre en asynchrone dans un job
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
    if self.week_basic_car == nil && self.week_electric_car == nil && self.week_moto == nil && self.week_public_trans == nil
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
    else
      self.detail[0] = base * ((self.week_basic_car || 0) + (self.week_electric_car || 0) * (1-0.7) + (self.week_moto || 0) * (1-0.5) + (self.week_public_trans || 0) * (1-0.62)) / 90 + 1.37*(self.long_flights || 0) + 0.34*(self.short_flights || 0)
    end
  end

  def set_house_score
    base = Country.find(country_id).detail[1].to_f
    if self.energy.present?
      case self.energy.to_sym when :électricité
        energy_modifier = -14.00/100
      when :gaz
        energy_modifier = 33.60/100
      when :fioul
        energy_modifier = 310.00/100
      when :bois
        energy_modifier = -72.00/100
      end
    end
    if self.enr.present?
      case self.enr.to_sym when :partiellement_renouvelable
        enr_modifier = -16.80/100
      when :fortement_renouvelable
        enr_modifier = -50.40/100
      end
    end
    self.detail[1] = base * (self.house_size / Country.find(country_id).house_size.to_f) * (1+ (energy_modifier||0)) * (1 + (enr_modifier||0)) * (2.3 / (house_people||2.3))
  end

  def set_food_score
    base = Country.find(country_id).detail[4].to_f
    if self.redmeat == nil && self.poultry == nil && self.dairy == nil
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
    else
      self.detail[4] = base + ((self.redmeat || 0) - 3) * 0.14 + ((self.poultry || 0) - 4) * 0.053 + ((self.dairy || 0) - 4) * 0.017
    end
  end

  def set_goods_score
    country = Country.find(country_id)
    self.detail[3] = country.detail[3].to_f * (1 + (((self.goods_furnitures || country.furniture) - country.furniture) + ((self.goods_clothes || country.clothes) - country.clothes) + ((self.goods_others || country.other_goods) - country.other_goods)) / (country.furniture+country.clothes+country.other_goods))
  end

  def set_services_score
    country = Country.find(country_id)
    self.detail[2] = country.detail[2].to_f * (1 + (((self.services_health || country.healthcare) - country.healthcare) + ((self.services_plans || country.subscriptions) - country.subscriptions) + ((self.services_others || country.other_services) - country.other_services)) / (country.healthcare + country.subscriptions + country.other_services))
  end

  def calculate_trends
    transactions = self.user.transactions.carbone_contribution
    carbone_by_category = Category.all.map{|c| [c.id, transactions.recent.category_id(c.id).sum(:carbone)]}.to_h
    top_category = [carbone_by_category.key(carbone_by_category.values.max) , carbone_by_category.values.max ]
    self.top_category = top_category

    top_transaction = transactions.recent.order("carbone DESC").first
    if top_transaction != nil
      self.top_transaction = [top_transaction.description, top_transaction.carbone]
    end

    growth_by_category = Category.all.map{|c| [c.id, 100*(transactions.recent.category_id(c.id).sum(:carbone) - transactions.where("date > ? AND date <= ?", 2.months.ago, 1.month.ago).category_id(c.id).sum(:carbone)) / transactions.where("date > ? AND date <= ?", 2.months.ago, 1.month.ago).category_id(c.id).sum(:carbone)]}.to_h
    top_growth = [growth_by_category.key(growth_by_category.values.reject(&:nan?).reject(&:infinite?).max), growth_by_category.values.reject(&:nan?).reject(&:infinite?).max, (transactions.recent.category_id(growth_by_category.key(growth_by_category.values.reject(&:nan?).reject(&:infinite?).max)).sum(:carbone) - transactions.where("date > ? AND date <= ?", 2.months.ago, 1.month.ago).category_id(growth_by_category.key(growth_by_category.values.reject(&:nan?).reject(&:infinite?).max)).sum(:carbone)) ]
    self.top_growth = top_growth
  end

  def set_match
    #créer le match + notifier le parrain que son adversaire est prêt
    if self.user.invited_by_id != nil
      Match.create(name: User.find(self.user.invited_by_id).name, user_id: self.user.id, opponent_id: self.user.invited_by_id, badge: 'badge_avatar.png', image: 'avatar.png')
      Match.create(name: self.user.name, user_id: self.user.invited_by_id, opponent_id: self.user.id, badge: 'badge_avatar.png', image: 'avatar.png')
    end
  end

  def update_onboarding
    user = self.user
    if self.kind.to_sym == :dynamic && self.total > 0
      user.onboarded = true
    elsif self.kind.to_sym == :static && self.regime.present?
      user.onboarded = true
    else
      user.onboarded = false
    end
    user.save
  end

  def refresh_reductions
    if self.user.onboarded == true
      ReductionGeneratorJob.perform_later(self.user)
    end
  end

end
