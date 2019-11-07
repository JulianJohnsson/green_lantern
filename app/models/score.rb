class Score < ApplicationRecord
  belongs_to :user
  belongs_to :country

  before_create :set_default
  before_save :sum_categories

  after_save :set_transport_score,  if: :saved_change_to_main_transport_mode?

  enum main_transport_mode: [:voiture_classique, :voiture_électrique, :moto_ou_scooter, :transports_en_commun, :vélo_ou_marche]

  def set_default
    country = Country.find(self.country_id)
    self.detail = country.detail
    self.sum_categories
  end

  def sum_categories
    self.total = self.detail.inject(0){|sum,x| sum.to_f + x.to_f }
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
    self.detail[0] = base * (1 + modifier)
    self.sum_categories
    self.save
  end
end
