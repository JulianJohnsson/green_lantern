class Preference < ApplicationRecord
  belongs_to :user

  accepts_nested_attributes_for :user

  enum regime: [:végétalien, :végétarien, :flexitarien, :moyen, :viandard]
  enum energy_contract: [:je_ne_sais_pas, :sans_energie_renouvelable, :partiellement_renouvelable, :totalement_renouvelable]
  after_initialize :set_default, :if => :new_record?

  def set_default
    self.regime ||= :moyen
  end

end
